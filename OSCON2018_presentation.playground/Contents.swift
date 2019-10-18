/**
 # Learning Swift with Playgrounds
 
    CODE        =>  github.com / thesecretlab / LearningSwiftAtOSCON2018
 
    ^^^ HAS ~900 lines of code I wrote lovingly on this topic
 
    PRESENTERS  =>  twitter.com / parisba || The_McJones || TheMartianLife
 */

import Foundation

/// Returns random integer between 0 and parameter
func randomNumber(upTo number: Int) -> Int {
    return Int(arc4random_uniform(UInt32(number + 1)))
}


//: Let's begin :D

// single-line results =>
1 + 10

// loop count and graphed results =>
for _ in 0...10 {
    randomNumber(upTo: 10)
}

// normal console log output
print("hello world")


//: ## Types
var integerVariable: Int = 1
integerVariable = 2

let integerConst = 1
//integerConst = 2 ERROR

let dinosaur = "🦖"
let 🦕 = "dinosAURRRR"

let doubleTypecast = 1 as Double
let doubleTypecast2 = Double(integerVariable)

var array = ["Hello", "world", "this", "is", "Mars"]
array += ["Other strings", "as a new array"]
array.append("single element")
array.count
array.first
array[3]


//: ## Operators

// Equation (do math)
1 + 1
1 / 1
1 * 1
pow(1, 2)


// Compound (equation & assignment in one)
var number = 1
number += 3

// Logic (boolean true/false)
number < 4


//: ## Flow Control

var thing = 1
var otherThing = 2

if thing == otherThing {
    otherThing += 1
}

var greatest = -1

if thing > otherThing {
    greatest = thing
} else {
    greatest = otherThing
}

let answer = 10
var guess = -1

while guess != answer {
    guess = randomNumber(upTo: 10)
}

var numbers = [1, 2, 3, 5]
var sum = 0

for number in 0..<numbers.count {
    sum += numbers[number]
}

sum

for number in numbers {
    sum += number
}

sum


//: ## Optionals
var normalInteger: Int = 1
//normalInteger = nil ERROR

var optionalInteger: Int? = 1
optionalInteger = nil


// Now how can we un-optional an optional so we can use it like normal
optionalInteger = 10

let integer = optionalInteger! // JUST DO IT, don't ask
print(integer.description)

print(optionalInteger?.description as Any) // DO IT MAYBE? or don't tell me

if let integer = optionalInteger {
    print(integer.description) // if we got here, it was okay
}

guard let integer = optionalInteger else {
    fatalError("IF YOU GOT HERE IT WAS NOT OKAY (INTEGER WAS NIL)") // must exit scope within guard loop
}

print(integer.description)

let integerFallback = optionalInteger ?? 0 // fallback value if first bit was nil


//: ## Functions

// reuse code with functions
func printNiceMessage() {
    print("Today is a beautiful day to OSCON!")
}

// can use both function-internal and function call (external) parameter labels
func makeShouting(from input: String) -> String {
    let word = input.replacingOccurrences(of: "[^A-Za-z]", with: "", options: .regularExpression) // input is internal passed parameter name
    let shout = word.uppercased()
    
    return shout + "!"
}

// from is external parameter label
makeShouting(from: "Mars is the best planet")


// higher-order functions that can be used with collections
let stringArray = ["This is a first", "this is a second", "this is a third", "and fourth"]

// get new array of elements that match code passed in braces
let newArray = stringArray.filter { $0.hasPrefix("this") }
newArray.count

// get new array of elements modified by code passed in braces
let uppercasedArray = stringArray.map { $0.uppercased() }
uppercasedArray.description

// get a single value from the array by iterating over it with the code passed in braces
let characterCount = stringArray.reduce(0) { $0 + $1.count }
characterCount


// closures
func getRandomBool(withFunc randomNumberGenerator: () -> Int) -> Bool { // a function as a parameter
    
    let random = randomNumberGenerator() // use it, however it works
    
    return random % 2 == 0 ? true : false // ternary operators are so great <3
}

// this is the function call
getRandomBool { // you can put braces and a block where the parameter must be a function or block
    return randomNumber(upTo: 9)
}

// alternate syntax
getRandomBool(withFunc: { return randomNumber(upTo: 9) })



// a better example is one that outputs a value back to the function it was passed to
typealias ArrayShuffler = ([String]) -> [String]

// we need a function that takes a function or block as a parameter
func assessShuffle(of array: [String], with shuffler: ArrayShuffler) -> Double {

    let shuffledArray = shuffler(array)
    let ideal = Double(array.count)
    var changeCount = ideal

    for index in 0..<array.count {

        if array[index] == shuffledArray[index] {
            changeCount -= 1
        }
    }

    return changeCount / ideal
}

// and an array to use with it
let array1 = ["A", "B", "C", "D", "E", "F", "G", "H"]

// and a function to pass it
func shuffle(_ array: [String]) -> [String] {
    var oldArray = array
    var newArray: [String] = []
    var index: Int

    while oldArray.count > 0 {

        index = randomNumber(upTo: oldArray.count - 1)
        newArray.append(oldArray[index])
        oldArray.remove(at: index)
    }
    
    return newArray
}

// noew we call it with a name given to its output
let performance = assessShuffle(of: array1, with: { array in return shuffle(array) })

// and we can assess the random shuffling of the input array
performance

//: ## Structs, Classes and Enums

struct Talk {
    let name: String
    var accepted: Bool
}

// structs come with free "memberwise" initialisers
let aiTalk = Talk(name: "Machine overlord and you", accepted: true)
let gameTalk = Talk(name: "Open Source game dev", accepted: true)
var swiftTalk = Talk(name: "Learning Swift with Playgrounds", accepted: false)

let talks = [aiTalk, gameTalk, swiftTalk]
//let talkName = Talk() ERROR

swiftTalk.accepted = true


// classes require an explicit initialisers if their attributes do not have default values
class Person {
    
    var name: String
    
    init(named name: String) {
        self.name = name
    }
}

// and now we can make some people
var people = [Person(named: "Paris"), Person(named: "Tim"), Person(named: "Mars")]

// but what if we want something more specific that has the same behaviours and attributes plus more
class Speaker: Person {
    
    var talks: [Talk]
    
    init(named name: String, presenting talks: [Talk]) {
        self.talks = talks
        super.init(named: name) // defers to superclass init for the rest
    }
    
    override init(named name: String) {
        self.talks = []
        super.init(named: name)
    }
}

people.removeAll() // our people  (Person typed) array

people = [
    Speaker(named: "Paris", presenting: talks)
] // perfectly fine because Speakers are still Person types

//: ## Protocols

// we can use the "protocol" keyword to make a name for a set of behaviours or attributes that something WILL have
// these are much like what some other languages call "interfaces"
protocol Describable {
    func describe() -> String // what it must have the ability to do if you say it adheres to "Describable"
}

// you can even extend base types to adhere to protocols
extension Int: Describable {
    
    func describe() -> String { // now it does
        return "An Integer of value \(self)"
    }
}

5.describe()

// you can also extend a protocol to give it a default implementation
extension Describable {
    
    func describe() -> String {
        return "A thing"
    }
}

// my favourite protocol is one that override the right sidebar output to be more useful with custom types =>
extension Speaker: CustomDebugStringConvertible {
    
    var debugDescription: String {
        return "This is the thing that will appear in the right sidebar live results for a Speaker type"
    }
}

people.first
