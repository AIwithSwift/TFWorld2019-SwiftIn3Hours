footer: @parisba / @the_mcjones /   @themartianlife / #TFWorld
theme: Zurich,6
slidenumbers: true

# Swift for Tensorflow<br>(in three hours)

---

![60%](presentation_images/team.png)

---

![50%](presentation_images/tasmania.png)

---

![100%](presentation_images/books.png)


---

![inline](presentation_images/docker.jpg)

---

# **Today's Plan**

1. Swift (for programming)
2. Swift (for TensorFlow)
3. Using Swift for TensorFlow
4. Using everything

---

[.build-lists: true]

# **Installation**

- `git clone https://github.com/google/swift-jupyter.git`
- `docker build -f docker/Dockerfile -t swift-jupyter .`
- `docker run -p 8888:8888 --cap-add SYS_PTRACE -v /my/host/notebooks:/notebooks swift-jupyter`

---

# **Today's Plan**

1. Swift (for programming)
2. Swift (for TensorFlow)
3. Using Swift for TensorFlow
4. Using everything

---

# [fit] Swift for TensorFlow isn't quite ready.

---

# [fit] Swift for TensorFlow isn't quite ready.
## It's _almost_ ready.

---

# [fit] Swift for TensorFlow isn't quite ready.
## It's _almost_ ready.
## _**almost**_

---

# [fit] Swift for TensorFlow isn't quite ready.
## It's _almost_ ready.
## _**almost**_
## ...Swift is **very** ready though!

---

# **Today's Plan**

1. Swift (for programming)
2. Swift (for TensorFlow)
3. Using Swift for TensorFlow
4. Using everything

^ Let's go back to our plan for a moment..


---

# **Today's Plan**

1. **Swift (for programming)**
2. Swift (for TensorFlow)
3. Using Swift for TensorFlow
4. Using everything

^ We're gonna start with Swift, for programming.

---

# **Swift (for programming)**

^ We're going to be teaching Swift, as a programming language, for the first bit of this tutorial. We're kind of just ignoring machine learning for this. It's important to learn Swift as a programming language before we move to Swift for TensorFlow.

---

# What's to learn? (Part 1)

* Variables and constants
* Types of Data
* Operators
* String interpolation
* Arrays
* Dictionaries

---

# What's to learn? (Part 2)
* Conditional statements
* Loops
* Switch case
* Functions
* Optionals
* Optional chaining
* Generics

---

# What's to learn? (Part 3)
* Enumerations
* Structs
* Classes
* Properties
* Static properties and methods
* Access control

---

# What's to learn? (Part 4)

* Polymorphism and typecasting
* Closures
* Protocols
* Extensions
* Protocol extensions

---

# Variables

```swift
var presenters = "Mars, Tim, and Paris"
presenters = "Mars and Tim and Paris"
```

# Constants

```swift
let presenters = "Mars, Tim, and Paris"
presenters = "Mars and Tim and Paris" // error
```

---

# Types

```swift
var conference
conference = "TensorFlow World 2019"
```

# Type Annotation

```swift
var conference: String
conference = "TensorFlow World 2019"
```

---

# Types + Safety

```swift
var conference: String
conference = "TensorFlow World"

var year: Int
year = 2019

year = "TensorFlow World" // error
conference = 2019 // error
```

---

# Operators

```swift
var num = 10 // 10
num = num + 10 // 11
num = num - 1 // 10
num = num * num // 100
```

---

# Operators

```swift
var num = 100
num += 100
num -= 100
```

---

# Operators

```swift
var p1 = "Mars"
var p2 = "Tim"
var p2 = "Paris"

var presenters = p1 + ", " + p2 + ", and " + p2
```

---

# Comparisons

```swift
var a = 55.5
var b = 100.2
var c = a + b

c > 155
c >= 155 
c > 160
c < 200
```

---

# Comparisons

```swift
var session = "Swift for TensorFlow in 3 hours"

session == "Swift for TensorFlow in 3 hours"
session != "Swift for TensorFlow in 10 hours"
```

---

# String Interpolation

```swift
var conference = "TensorFlow World"
var session = "Swift for TensorFlow in 3 hours"
"\(conference) has a session called '\(session)'"
```

# String Interpolation with Multiple Types

```swift
var year = 2019
"\(conference) in \(year) has a session called '\(session)'"
```

---

# Arrays

```swift
var spaceships = 
    ["USS Enterprise", 
    "Serenity", 
    "White Star", 
    "Red Dwarf", 
    "Millenium Falcon"]
spaceships[2] // White Star

type(of: spaceships) // Array<String>.Type
```

---

# Arrays

```swift
var favouriteNumbers: [Int] = []
favouriteNumber[0] = 42
```

---

# Dictionaries

```swift
var session = [
                "title": "Swift for TensorFlow in 3 Hours",
                "type": "tutorial",
                "event": "TensorFlow World",
                "year": 2019,
                "location": "Santa Clara"
            ]
```

---

# Conditions with if

```swift
var check = 1

if check == 1 {
    print("Check was 1!")
} else if check == 2 {
    print("Check was 2!")
} else {
    print("Check was something else!")
}
```

---

# Multiple conditions with if

```swift
var check = 1
var doubleCheck = 1

if check == 1 && doubleCheck == 1 {
    print("Things are good!")
}
```

---

# Loops with closed range operator

```swift
for i in 1...10 {
    print("\(i) x 10 is \(i * 10)")
}
```

# Loops where you don't care about the count

```swift
for _ in 1 ... 5 {
    print("This will print five times.")
}
```

---

# Looping over data

```swift
var sciFiRomances = [
    "Delenn and Sheridan", 
    "Aeryn and Crichton", 
    "Garak and Bashir"]

for romance in sciFiRomances {
    print("\(romance) is a great sci-fi romance.")
}
```

---

# Switches

```swift
let planet = "Jupiter"

switch(planet) {
    case "Mars":
        print("Both a planet, and one of the presenters")
    case "Pluto":
        print("Not a planet.")
    case "Jupiter":
        print("Gaseous planet.")
    case default:
        print("No fact for you!")   
}
```

---

# Functions

```swift
func favouriteFood() {
    print("My favourite food is pizza.")
}

favouriteFood()
```

---

# Functions with parameters

```swift
func favouriteFood(name: String) {
    print("My favourite food is \(name)")
}

favouriteFood(name: "pizza")
```

---

# Functions with multiple parameters

```swift
func favouriteAlbum(name: String, artist: String) {
    print("My favourite album is \(name) by \(artist)")
}

func favouriteAlbum(name: String) {
    print("My favourite album is \(name)")
}
```

---

# Functions with return values

```swift
func checkFavouriteFood(name: String) -> Bool {
    switch(name) {
        case "pizza":
            return true
        case "pasta":
            return false
        case "burrito":
            return true
        default:
            return false
    }
}
```

---

# Optionals

TODO

---

# Force unwrapping optionals

TODO

---

# Implicitly unwrapped optionals

TODO

---

# Optional chaining

TODO

---

# nil coalescing operator

TODO

---

# Enumerations

---

# Activity
# Basic XOR 

---

# Activity | Basic XOR | Model

```swift
import TensorFlow

// Create a XORModel Struct
struct XORModel: Layer
{
  // define three layers, each of Dense type
  var inputLayer = Dense<Float>(inputSize: 2, outputSize: 2, activation: sigmoid)
  var hiddenLayer = Dense<Float>(inputSize: 2, outputSize: 2, activation: sigmoid)
  var outputLayer = Dense<Float>(inputSize: 2, outputSize: 1, activation: sigmoid)
  
  // procide the differentiable thingo
  @differentiable func callAsFunction(_ input: Tensor<Float>) -> Tensor<Float>
  {
    return input.sequenced(through: inputLayer, hiddenLayer, outputLayer)
  }
}
```

---

## Activity | Basic XOR | Preparing for Training

```swift
// create an instance of our XORModel Struct (defined above)
var model = XORModel()

// create an optimizer (standard gradient descent)
let optimizer = SGD(for: model, learningRate: 0.02)

// create some training data
let trainingData: Tensor<Float> = [[0, 0], [0, 1], [1, 0], [1, 1]]

// label the training data (so we know the correct outputs)
let trainingLabels: Tensor<Float> = [[0], [1], [1], [0]]
```

---

# Activity | Basic XOR | Training the Model

```swift
// train to 100,000
for epoch in 0..<100_000
{
    // do the ting
    let 𝛁model = model.gradient { model -> Tensor<Float> in
        let ŷ = model(trainingData)
        let loss = meanSquaredError(predicted: ŷ, expected: trainingLabels)
        if epoch % 5000 == 0
          print("epoch: \(epoch) loss: \(loss)")
        return loss
    }
    optimizer.update(&model, along: 𝛁model)
}
```

---

# Activity | Basic XOR | Testing the Model

```swift
print(round(model.inferring(from: [[0, 0], [0, 1], [1, 0], [1, 1]])))
```

---

[.code-highlight: all]
[.code-highlight: 1]
[.code-highlight: 3,13]
[.code-highlight: 4-7]
[.code-highlight: 9-12]
[.code-highlight: 14]
[.code-highlight: 15]
[.code-highlight: 16]
[.code-highlight: 16-17]

```swift
import TensorFlow

struct MLPClassifier {
    var w1 = Tensor<Float>(repeating: 0.1, shape: [2, 4])
    var w2 = Tensor<Float>(shape: [4, 1], scalars: [0.4, -0.5, -0.5, 0.4])
    var b1 = Tensor<Float>([0.2, -0.3, -0.3, 0.2])
    var b2 = Tensor<Float>([[0.4]])

    func prediction(for x: Tensor<Float>) -> Tensor<Float> {
        let o1 = tanh(matmul(x, w1) + b1)
        return tanh(matmul(o1, w2) + b2)
    }
}
let input = Tensor<Float>([[0.2, 0.8]])
let classifier = MLPClassifier()
let prediction = classifier.prediction(for: input)
print(prediction)
```

<!-- Specifically, this tutorial will:

begin with a Swift programming tutorial, covering how to use Swift, as a programming language (we’ll use both Apple’s playgrounds, if you have a macOS device, as well as Jupyter notebooks)

move to a Swift for TensorFlow tutorial, exploring fundamental machine learning problem solving using TensorFlow and Swift

explore and demonstrate common use cases for TensorFlow, using Swift

demonstrate the use of numpy, the ubiquitous Python library, from Swift, to perform common and useful data science operations, and 
integrate the results with Swift for TensorFlow

conclude be bringing all the components together: Swift programming (in a notebook), showcasing common ML problem-solving processes using Swift for TensorFlow, and integrating Python libraries as needed in a pragmatic manner -->
