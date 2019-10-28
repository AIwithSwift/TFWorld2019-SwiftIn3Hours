import Foundation
import TensorFlow

// Copyright 2019 The TensorFlow Authors. All Rights Reserved.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//     http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

import Foundation

#if canImport(FoundationNetworking)
    import FoundationNetworking
#endif

public struct DatasetUtilities {
    public static let curentWorkingDirectoryURL = URL(
        fileURLWithPath: FileManager.default.currentDirectoryPath)

    public static func fetchResource(
        filename: String,
        remoteRoot: URL,
        localStorageDirectory: URL = curentWorkingDirectoryURL
    ) -> Data {
        print("Loading resource: \(filename)")

        let resource = ResourceDefinition(
            filename: filename,
            remoteRoot: remoteRoot,
            localStorageDirectory: localStorageDirectory)

        let localURL = resource.localURL

        if !FileManager.default.fileExists(atPath: localURL.path) {
            print(
                "File does not exist locally at expected path: \(localURL.path) and must be fetched"
            )
            fetchFromRemoteAndSave(resource)
        }

        do {
            print("Loading local data at: \(localURL.path)")
            let data = try Data(contentsOf: localURL)
            print("Succesfully loaded resource: \(filename)")
            return data
        } catch {
            fatalError("Failed to contents of resource: \(localURL)")
        }
    }

    struct ResourceDefinition {
        let filename: String
        let remoteRoot: URL
        let localStorageDirectory: URL

        var localURL: URL {
            localStorageDirectory.appendingPathComponent(filename)
        }

        var remoteURL: URL {
            remoteRoot.appendingPathComponent(filename).appendingPathExtension("gz")
        }

        var archiveURL: URL {
            localURL.appendingPathExtension("gz")
        }
    }

    static func fetchFromRemoteAndSave(_ resource: ResourceDefinition) {
        let remoteLocation = resource.remoteURL
        let archiveLocation = resource.archiveURL

        do {
            print("Fetching URL: \(remoteLocation)...")
            let archiveData = try Data(contentsOf: remoteLocation)
            print("Writing fetched archive to: \(archiveLocation.path)")
            try archiveData.write(to: archiveLocation)
        } catch {
            fatalError("Failed to fetch and save resource with error: \(error)")
        }
        print("Archive saved to: \(archiveLocation.path)")

        extractArchive(for: resource)
    }

    static func extractArchive(for resource: ResourceDefinition) {
        print("Extracting archive...")

        let archivePath = resource.archiveURL.path

        #if os(macOS)
            let gunzipLocation = "/usr/bin/gunzip"
        #else
            let gunzipLocation = "/bin/gunzip"
        #endif

        let task = Process()
        task.executableURL = URL(fileURLWithPath: gunzipLocation)
        task.arguments = [archivePath]
        do {
            try task.run()
            task.waitUntilExit()
        } catch {
            fatalError("Failed to extract \(archivePath) with error: \(error)")
        }
    }
}


public struct MNIST {
    public let trainingImages: Tensor<Float>
    public let trainingLabels: Tensor<Int32>
    public let testImages: Tensor<Float>
    public let testLabels: Tensor<Int32>

    public let trainingSize: Int
    public let testSize: Int

    public let batchSize: Int

    public init(
        batchSize: Int, flattening: Bool = false, normalizing: Bool = false,
        localStorageDirectory: URL = DatasetUtilities.curentWorkingDirectoryURL
    ) {
        self.batchSize = batchSize

        let (trainingImages, trainingLabels) = fetchDataset(
            localStorageDirectory: localStorageDirectory,
            imagesFilename: "train-images-idx3-ubyte",
            labelsFilename: "train-labels-idx1-ubyte",
            flattening: flattening,
            normalizing: normalizing)

        self.trainingImages = trainingImages
        self.trainingLabels = trainingLabels
        self.trainingSize = Int(trainingLabels.shape[0])

        let (testImages, testLabels) = fetchDataset(
            localStorageDirectory: localStorageDirectory,
            imagesFilename: "t10k-images-idx3-ubyte",
            labelsFilename: "t10k-labels-idx1-ubyte",
            flattening: flattening,
            normalizing: normalizing)
        self.testImages = testImages
        self.testLabels = testLabels
        self.testSize = Int(testLabels.shape[0])
    }
}

extension Tensor {
    public func minibatch(at index: Int, batchSize: Int) -> Tensor {
        let start = index * batchSize
        return self[start..<start+batchSize]
    }
}

fileprivate func fetchDataset(
    localStorageDirectory: URL,
    imagesFilename: String,
    labelsFilename: String,
    flattening: Bool,
    normalizing: Bool
) -> (images: Tensor<Float>, labels: Tensor<Int32>) {
    guard let remoteRoot: URL = URL(string: "http://yann.lecun.com/exdb/mnist") else {
        fatalError("Failed to create MNST root url: http://yann.lecun.com/exdb/mnist")
    }

    let imagesData = DatasetUtilities.fetchResource(
        filename: imagesFilename,
        remoteRoot: remoteRoot,
        localStorageDirectory: localStorageDirectory)
    let labelsData = DatasetUtilities.fetchResource(
        filename: labelsFilename,
        remoteRoot: remoteRoot,
        localStorageDirectory: localStorageDirectory)

    let images = [UInt8](imagesData).dropFirst(16).map(Float.init)
    let labels = [UInt8](labelsData).dropFirst(8).map(Int32.init)

    let rowCount = labels.count
    let (imageWidth, imageHeight) = (28, 28)

    if flattening {
        var flattenedImages = Tensor(shape: [rowCount, imageHeight * imageWidth], scalars: images)
            / 255.0
        if normalizing {
            flattenedImages = flattenedImages * 2.0 - 1.0
        }
        return (images: flattenedImages, labels: Tensor(labels))
    } else {
        return (
            images:
                Tensor(shape: [rowCount, 1, imageHeight, imageWidth], scalars: images)
                    .transposed(withPermutations: [0, 2, 3, 1]) / 255,  // NHWC
            labels: Tensor(labels)
        )
    }
}

public func createDirectoryIfMissing(at path: String) throws {
    guard !FileManager.default.fileExists(atPath: path) else { return }
    try FileManager.default.createDirectory(
        atPath: path,
        withIntermediateDirectories: false,
        attributes: nil)
}


public struct Image {
    public enum ByteOrdering {
        case bgr
        case rgb
    }

    enum ImageTensor {
        case float(data: Tensor<Float>)
        case uint8(data: Tensor<UInt8>)
    }

    let imageData: ImageTensor

    public init(tensor: Tensor<UInt8>) {
        self.imageData = .uint8(data: tensor)
    }

    public init(tensor: Tensor<Float>) {
        self.imageData = .float(data: tensor)
    }

    public init(jpeg url: URL, byteOrdering: ByteOrdering = .rgb) {
        let loadedFile = Raw.readFile(filename: StringTensor(url.absoluteString))
        let loadedJpeg = Raw.decodeJpeg(contents: loadedFile, channels: 3, dctMethod: "")
        if byteOrdering == .bgr {
            self.imageData = .uint8(
                data: Raw.reverse(loadedJpeg, dims: Tensor<Bool>([false, false, false, true])))
        } else {
            self.imageData = .uint8(data: loadedJpeg)
        }
    }

    public func save(to url: URL, quality: Int64 = 95) {
        // This currently only saves in grayscale.
        let outputImageData: Tensor<UInt8>
        switch self.imageData {
        case let .uint8(data): outputImageData = data
        case let .float(data):
            let lowerBound = data.min(alongAxes: [0, 1])
            let upperBound = data.max(alongAxes: [0, 1])
            let adjustedData = (data - lowerBound) * (255.0 / (upperBound - lowerBound))
            outputImageData = Tensor<UInt8>(adjustedData)
        }

        let encodedJpeg = Raw.encodeJpeg(
            image: outputImageData, format: .grayscale, quality: quality, xmpMetadata: "")
        Raw.writeFile(filename: StringTensor(url.absoluteString), contents: encodedJpeg)
    }

    public func resized(to size: (Int, Int)) -> Image {
        switch self.imageData {
        case let .uint8(data):
            return Image(
                tensor: Raw.resizeBilinear(
                    images: Tensor<UInt8>([data]),
                    size: Tensor<Int32>([Int32(size.0), Int32(size.1)])))
        case let .float(data):
            return Image(
                tensor: Raw.resizeBilinear(
                    images: Tensor<Float>([data]),
                    size: Tensor<Int32>([Int32(size.0), Int32(size.1)])))
        }

    }
}

public func saveImage(_ tensor: Tensor<Float>, size: (Int, Int), directory: String, name: String) throws {
    try createDirectoryIfMissing(at: directory)
    let reshapedTensor = tensor.reshaped(to: [size.0, size.1, 1])
    let image = Image(tensor: reshapedTensor)
    let outputURL = URL(fileURLWithPath:"\(directory)\(name).jpg")
    image.save(to: outputURL)
}
