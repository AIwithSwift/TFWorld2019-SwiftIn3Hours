// import statements should be at the top
import Foundation

/*
 Swift is a compiled, statically typed, multiparadigm language designed to be **safe** and **fast**. First released by Apple in 2014, it was built upon the LLVM compiler framework and allows for C, Objective-C, C++ and Swift code to coexist within a single application. It is also entirely Open Source (yay!).
 
 At its core, Swift is inspired by the C family of languages; it takes a lot of its basics from the well-established syntax of its predecessors. Though quite a few hard requirements have been removed for cleanliness in Swift, there is often nothing stopping you from doing it anyway--such as is the case with statement-ending semicolons.
 */
1 + 1; // for example, this line executes just fine with a semicolon on the end

2 + 2  // but so does this, so why bother?

/*:
 # Types
 
 Swift comes with all the standard types straight out of the box: Strings, Integers, Doubles (floating point numbers), Booleans and many more. Types are simply declared and types with a neat and readable syntax. We'll start with the basics...
 */
//: Stored values can be variable or constant, whose value cannot be changed once assigned. These are determined by the use of the 'var' or 'let' keyword in their initial declaration. This can be used to keep safe the values you need to know but that you want to make sure are never changed. Xcode will pick up on any violations at compile time.
var integerVariable: Int = 1
integerVariable = 2 // perfectly fine to do

let integerConstant: Int = 1
//integerConstant = 2 // ERROR: Cannot assign to value: 'integerConstant' is a 'let' constant
//: Declarations can also be explicitly or implicitly typed--this is sometimes called Static Typing versus Type Inference. Where not declared, Swift will default to whichever basic type it thinks is most likely based on what value you initially give it, if it is able. Because of this, a declaration that is not being assigned a value in the same line cannot be implicitly-typed.
let explicitInteger: Int = 1
type(of: explicitInteger) // Integer Type

let implicitInteger = 1
type(of: implicitInteger) // also an Integer Type
//: This works for quite a few different types of values, but not always as you'd expect.
let implicitDouble = 1.0
type(of: implicitDouble)

let implicitString = "s"
type(of:implicitString) // NOTE: it does not infer Char for single-character Strings
//: To be sure, you can always option-click on a variable's name to see its Type.
var mysteryTypedVariable = [5, 4, 3, 2, 1.0]
//: As well as the Playgrounds environment, Swift itself also supports full Unicode in its Strings. Yes, you can make emoji variable names. No, you should not make emoji variable names. But this support is great for not breaking other things and for robust localization.
let 🦕 = "dinosaur"
let dinosaur = "🦖"
//: Swift is a **very** strongly typed language, and the compiler is very picky about ensuring type safety. Many types however support direct typecasting:
let typeCastDouble = 1 as Double
//: For others, they may require a custom function to be written or some extra information. But usually it is a simple case of initialising the new type with the old value, like so:
let typecastDouble = Double(integerVariable)
let typecastInteger = Int(typecastDouble)

//: Collection types such as Arrays and Dictionaries are especially clean and intuitive in Swift. They can easily be declared and manipulated with literals that leave the initialisation to the machine.
var stringArray = ["First element", "Second element", "Third element"]
stringArray += ["More Array elements", "Can be added en masse", "As either addition of two or more Arrays"]
stringArray.append("Or as one element at a time")
//: You can insert, find or remove elements in many ways, as well as obtaining subsequences, descriptions, hashes and more of the Array.
stringArray.insert("Zero-th element", at: 0)
stringArray.count
stringArray.dropLast(4)
//: You can also directly insert and address elements using subscripts:
stringArray[0] = "New Zero-th element"
let secondElement = stringArray[1]
/*:
 # Operators
 
 It's a programming langauge: it has maths and logic. You can do maths with the math bits and logic with the logic bits and sometimes--*if you're feeling saucy*--logic with the maths bits or maths with the logic bits.
 */
//: Swift has some math operators you would expect...
let addition        = 2 + 1 // two plus one
let subtraction     = 2 - 1 // two minus one
let multiplication  = 2 * 1 // two times one
let division        = 2 / 1 // two divided by one (integer division)
let modulo          = 2 % 1 // remainder from two integer division one
//: ...it also doesn't have some you might expect though...
//let exponential     = 2 ** 1 // ERROR: Use of unresolved operator '**' (doesn't exist in Swift)
let exponential     = pow(2, 1) // two to the power of one (function included in Foundation library)
//: ...it has some comparison operators too...
let greater   = 2 > 1  // boolean representing whether two is greater than one
let less      = 2 < 1  // boolean representing whether two is less than one
let equal     = 2 == 1 // boolean representing whether two is equal to one
//: ...and some compound operators for some of the above put together.
// you can skip steps when changing and then re-assigning in one step
var number = 2
//number = number + 1
number += 1 // left side equals left side plus right side (addition and assignment in one step)
//number = number - 2
number -= 2 // left side equals left side minus right side (subtraction and assignment in one step)
//number = number * 4
number *= 4 // left side equals left side times by right side (multiplication and assignment in one step)
//number = number / 2
number /= 2 // left side equals left side divided by right side (division and assignment in one step)


// but not in the way many other languages allow
//number++ // ERROR: Unary operator '++' cannot be applied to an operand of type '@lvalue Int' (doesn't exist, such unary operators deprecated from the language in Swift 3)


// you can be less restrictive in your checks
let greaterOrEqual  = 2 >= 1 // boolean representing whether two is greater than OR EQUAL TO one
let lessOrEqual     = 2 <= 1 // boolean representing whether two is less than OR EQUAL TO one
let notEqual        = 2 != 1 // boolean representing whether two is not equal to one


// or more restrictive
class SomeObject {}     // some fake object class
let oneObject       = SomeObject()  // a default object of that class
let anotherObject   = SomeObject()  // another default object of that class

let same            = oneObject === anotherObject // boolean representing whether oneObject and anotherObject are THE SAME OBJECT, regardless of whether they have the same values

/*:
 There are also a range of operators for bitwise calculation or manipulation and and compound operators that allow overflow handling in multiplication and division, but that is likely more maths than you will need at this point. You can declare your own operators too, similarly to how you'd declare a function. More details can be found [here](https://docs.swift.org/swift-book/LanguageGuide/BasicOperators.html) and [here](https://docs.swift.org/swift-book/LanguageGuide/AdvancedOperators.html).
 
 As you saw above with some String manipulation, there is also the "dot" operator. This accesses properties and functions that the preceding variable or type has. For example...
 */
stringArray.count       // every Array type has an inbuilt value called "count" that will return an Int representing the number of elements it contains
stringArray.removeAll() // Arrays also have the ability to clear all their elements at once
//: When we talk about custom types a little later, you will see how you can give new values and behaviours to existing and custom types that can then be accessed this way.
/*:
 # Flow Control
 
 So we can now write lines of code and run them in order. That's all well and good, but what about when we want to run--or even repeat--different segments depending on or to cause different behaviours? We need flow control structures: things that allow us to skip or repeat code.
 */
//: You can use the "if" or "if-else" structure to take different paths or omit code based on certain conditions.
// declare some values
var thing = 1
var otherThing = 2


// and you can check them with a structure like this
if thing == otherThing {
    otherThing += 1
}


// or this
var greatest = 0

if thing > otherThing {
    
    greatest = thing
} else {
    
    greatest = otherThing
}

//: But who could forget a personal favourite of ours, the ternary operator. This question mark-colon pairing means "if the first third is true then do the second third, else the third third". It's a handy and readable shorthand.
greatest = thing > otherThing ? thing : otherThing

//  reads as greatest equals (if thing > otherthing then thing else otherThing)
//: This is also useful for doing different actions based on a boolean check
let todayString = String(describing: Date()) // the datetime right now as a String
//todayString.hasPrefix("2018-07-19 16") ? print("It's TALK TIME!") : print("False Alarm")

//: You can run a block multiple times until a desired point is reached using a "while" loop.
let answer = 10
var guess = -1

while guess != answer {
    
    guess =  Int.random(in: 0 ... 10) // a random number between 0 and 10
}
// to get here the block above will need to repeat one to theoretically infinite times
// once you get here, you know guess must equal answer

//: Where iteration indices are needed or a loop should happen a fixed number of times, "for-in" loops can be used. There are many forms of the syntax that can be used for this, here are just a few examples:
var numbers = [1, 5, 10]
var sum = 0


// OPTION 1: a numeric range
for number in 0..<numbers.count { // for number in 0 to less than 3 (0, 1, 2)
    sum += numbers[number]
}

sum


// OPTION 2: a collection
for number in numbers { // for each item in collection
    sum += number
}

sum

// OPTION 3: a handy combination of the two
var status = ""

for (index, value) in numbers.enumerated() {
    status += "Loop \(index + 1): \(value) was added. "
    sum += number
}

sum

//: Other structures are used to ensure code is only run if other unsafe conditions do not occur, or to recover from them if they do. The "do try-catch" structure is a good catch-all for wrapping unsafe blocks of code in.
let unsafeVariable: String? = "Some unsafe value we're not sure will be valid at runtime."


//extension String: Error {} // make some new object that can BE an Error

/// A function that can "throw" an error
func threeHater(_ input: Int) throws {
    
    let error = "INPUT WAS A THREE! ARGH!"
    
    if input == 3 {
        throw error
    }
}


do {
    
    try threeHater(2)
    //try threeHater(3)
} catch {
    
    // throw an error or perform a recovery here
    // multiple "catch" clauses can be used to catch different error conditions where needed
    print(error)
}

//: There are more specific keywords and structures that can be used when a single variable is uncertain or unsafe.

/*:
# Optionals

Swift basic types are non-nullable: if they have ever been initialised they can never NOT have a value of their declared of inferred type. Clean types are all well and good, and these restrictions are some of what makes Swift such a safe language, but in the real world we often pass around objects or values we didn't create or have complete control over.

Enter the Optional type.
*/

var normalInteger: Int = 1
//normalInteger = nil // ERROR: Nil cannot be assigned to type 'Int'

var optionalInteger: Int? = 1
optionalInteger = nil

/*:
 However, while this makes the value nullable, it does not allow us the same operations as the original non-Optional type does. To do many things, we must do more than just assume there will be a value to operate on (because the compiler just doesn't trust you any more, you've been wrong before). So we have to perform an "unwrapping" to extract the value as its underlying type. To do so, there are a few options:
 - Using an exclamation mark on an optional Type. Basically saying to the compiler "there will be a number, trust me". **This will crash if you are wrong. Don't do this; you are not too cool for memory safety!**
 - A let-var structure. Basically "if this assignment to a non-Optional type resolves without crashing, do the thing within the block".
 - A guard-let structure. Basically the opposite, "if this assignment to a non-Optional type causes a crash, do the thing within the block".
 */

optionalInteger = 10

func addPi(to optionalInteger: Int?) -> Double {
    
    let π = Double.pi
    var double: Double = 0
    
    // OPTION 1:
    //let integer = optionalInteger! // BADBADBAD
    
    
    // OPTION 2:
    if let integer = optionalInteger { // integer is now a normal Int type
        double = Double(integer) // you can use it as such
    }
    
    
    // OPTION 3:
    guard let integer = optionalInteger else { // declare the thing you expect will succeed
        return π // exits the current scope to avoid the crash if it didn't go the way you expected
    }
    
    double = Double(integer)
    
    return double + π
}


addPi(to: optionalInteger)

//: There is also a **nil-coalescing** operator that allows a fallback value if the original is nil. This is shown as two question marks.
let integer = optionalInteger ?? 0 // if the first thing turns out to be nil, be the second instead

/*:
 # Functions
 
 Sometimes you've figured out a clever way to do something, but it takes a lot of steps and you don't want to clutter up your code--or more likely you'll be wanting to use it more than once. To avoid the re-writing of code, we can give a set of steps a name that we can call it by. These are called functions.
 
 Functions in Swift are very tidy, and have syntax that allows the combination of a function's name and parameter labels to form a descriptive sentence.
 */

func printNiceMessage() {
    
    print("Today is a beautiful day.")
}

//printNiceMessage()

//: When we bring in the concept of input parameters, Swift also offers a nice syntax for declarative comments that can be found by others in the option-click quickhelp.

/**
 Take input string, remove all non-alphabetic characters (including spaces), uppercase all letters and append an exclamation mark.
 
 - parameters:
    - from: A String to shout-ify
 
 - returns:
    A single-word shout-ified String
 */

func makeShouting(from input: String) -> String { // notice this declaration contains two parameter labels
    
    // the second one is how this value is referred to internally to the function
    let word = input.replacingOccurrences( of:"[^A-Za-z ]", with: "", options: .regularExpression)
    let shout = word.uppercased()
    
    return shout + "!"
}

// the first label is now what we use externally when we call the function, making a human-readable statement
let statement = makeShouting(from: "Mars is the best planet; it's got a mountain that's two and a half times the height of Everest.")

statement

//: The use of this parameter label functionality is non-compulsory, as when only a single word is used it becomes the label used both internally *and* externally. Similarly, to be able to pass a parameter without a label, we can use an underscore as the externally-used label. A single function that accepts multiple parameters may use any combination of these.

func double(integer: Int) -> Int {
    
    return integer * 2
}


func triple(_ integer: Int) -> Int {
    
    return integer * 3
}


double(integer: 1)
triple(1)

//: The order of the parameters is important, they must match the order they are declared in the function definition.
//: The idea being that Swift function calls should be read out loud to tell you what they do.
//: This doesn't always work.

func doAThing(withThis string: String, using int: Int) {
    
    string
    int
    
    //print("doing a thing with this \(string) and using \(int)")
}


doAThing(withThis: "string", using: 5)

//: The above works, but this won't
//doAThing(using: 5, withThis: "string") // ERROR: Argument 'withThis' must precede argument 'using'

//: Function **overloading** allows a single function name to be called that will refer to different functions behind the scenes.

func reverse(_ string: String) -> String {
    
    return String(string.reversed())
}


func reverse(_ integer: Int) -> Int {
    
    var current = integer
    var numberString = ""
    
    while current / 10 != 0 {
        numberString += String(current % 10) // append smallest digit to string
        current /= 10 // divide running total by ten
    }
    
    let reversed = Int(numberString) ?? 0 // if an integer can be made of reversed String, return that. Otherwise, return zero.
    
    return reversed
}


reverse("letters")  // others can now use a function seemingly independent of input type
reverse(123)        // but they are handled correctly

//: Swift functions also support default values for non-passed parameters.
func dateDescription(_ date: Date = Date()) -> String {
    
    return date.description
}


let futureDate = Date(timeIntervalSinceNow: TimeInterval(1000.0))

dateDescription(futureDate)  // "date" within the function will use futureDate
dateDescription()            // "date" within the function will use Date() (the datetime when the code is run)

//: Many Swift Collection types also have a number of "higher-order functions" that can be applied to them for powerful manipulation with fast results. These take a function or block to execute in conjunction with the operation you called.

// you can fetch all elements that match a certain criteria
stringArray = ["First element", "Second element", "Third element", "last element in the array"]
let elementsArray = stringArray.filter { $0.hasSuffix("element") }
elementsArray.description


// you can change every element in the Array in a certain way
let uppercasedStringArray = stringArray.map { $0.uppercased() }
uppercasedStringArray.description

// or you can reduce the Array to a single value using some method
let characterCount = stringArray.reduce(0) { $0 + $1.count }
characterCount
//: Lots of things can be done with collections like these once constructed.
let adjectivesArray = ["cool", "fun", "unique"]
var ways = ""

for adjective in adjectivesArray {
    ways += "Things can also be looped over in a number of \(adjective) ways. "
}

ways
//: you can also iterate over multiple arrays at once using zip
let a1 = [1,2,3,4,5]
let a2 = ["a","b","c","d","e"]

for (number, string) in zip(a1, a2) {
    number
    string
    
    //print("\(string) is in alphabet at position \(number)")
}

//: Complicated things can also be done with single Strings as a collection of characters such a manipulating, appending or removing single or ranges of characters.
var string = "Bool"
string.remove(at: string.startIndex) // removes "B" from start
string.insert("C", at: string.startIndex) // inserts "C" at start in its place
string.append("!")
string

// or separating them into components for further manipulation
let longString = "a string made up of multiple words"
let wordsArray = longString.components(separatedBy: " ")
wordsArray.count

// method chaining does work in Swift also
let longerWordsArray = longString.components(separatedBy: " ").filter { $0.count > 4 }.map { $0.localizedCapitalized }
longerWordsArray.count

/*:
 While these are simple demonstrations of how passing conditions or functions to another function can be useful, the true power of closures becomes clear in cases such as where the certain chain of events must defy otherwise asynchronous execution, or where execution of a block will depend on an object it can have no knowledge of.
 
 You can pass a function or block like any parameter to another function or object, to be executed conditionally or upon its completion.
*/

func getRandomBool(_ randomNumberGenerator: () -> Int) -> Bool {
    
    let random = randomNumberGenerator() // gets some random integer, we have no idea how
    
    return random % 2 == 0 ? true : false // return true if odd or false if even
}

getRandomBool { // this requires a block or function to be passed as its parameter
    return Int.random(in: 0 ... 9) // get a random integer 0 - 9
}

//: You can also do this with a typealias, making a neater function declaration.
typealias ArrayShuffler = ([String]) -> [String]

/// A function that takes an Array of Strings and shuffles it, then returns an assessment of the shuffle function
func assessShuffle(of array: [String], with shuffler: ArrayShuffler) -> Double {
    
    let shuffledArray = shuffler(array) // shuffle the array
    let ideal = Double(array.count)     // the ideal number of changed elements is all of them
    var changeCount = ideal             // a count of how many were actually changed
    
    for index in 0..<array.count {      // iterate over array
        
        // if it's the same value as the corresponding spot in the shuffled array
        if array[index] == shuffledArray[index] {
            changeCount -= 1 // decrement the count of actual changes
        }
    }
    
    return changeCount / ideal // return as a percentage of ideal
}

// now we need an array to shuffle
let array = ["A", "B", "C", "D", "E"]

// and a function to shuffle it with
func myShuffle(_ array: [String]) -> [String] {
    // You could implement your own shuffle here, but why bother?
    let newArray = array.shuffled()
   
    return newArray // return the new array as input to the function this block is input to
}

// now we can easily assess shuffling of our array with our shuffler
let performance = assessShuffle(of: array, with: { array in return myShuffle(array) })

performance

/*:
 # Structs, Classes and Enums
 
 To model things intelligently, it often makes sense for a group of values to be associated in some way. Because of this, Swift has a few different ways to create custom types that possesses properties and behaviours that may or may not be able to be changed.
 */

struct Talk {
    
    let name: String
    var accepted: Bool
}

//: They can then be used like any other value, using the dot operator to access its properties and functions.
let aiTalk = Talk(name: "Machine overlord and you: Building AI on iOS with open source tools", accepted: true)
let gameTalk = Talk(name: "Open Source Game Development with Godot", accepted: true)
var swiftTalk = Talk(name: "Learning Swift with Playgrounds", accepted: false)

swiftTalk.accepted = true
//swiftTalk.name = "Plearning Lift with Swaygrounds" // ERROR: Cannot assign to property: 'name' is a 'let' constant
//aiTalk.accepted = false // ERROR: Cannot assign to property: 'aiTalk' is a 'let' constant

//: It is worth noting here that using the 'let' keyword for an object variable means that it can not be reassigned a new **object** but it also mean the attributes the object *holds* can't be changed, even if they were declared variable. The opposite is also true: an object can be declared with 'var' and it will be able to be assigned different objects, but any values declared constant within each object still cannot be changed.
let talks = [aiTalk, gameTalk, swiftTalk]


for talk in talks {
    
    if talk.accepted {
        
        // Do a thing
    }
}

/*:
 But you can't make a heirarchy of structs. They have no concept of inheritance, so any change in structure or behaviour would require a new declaration of an un-associated type. For such purposes, we use classes.

 They can also be written either so that many of then can be made, or so that there is always only a single instance that is shared by all references to it. This is useful for making sure that you always have the right copy of something and that any changes are applied to only that.
 
 If a *class*'s attributes are not given default values, you are required to declare an initialiser for the class. You may have noticed that our *structs* did not require initialiser declaration; a default member-wise initialiser is inferred and automatically available for use if you do not declare a custom one.
 */

class Person {
    
    var name: String
    
    init(named name: String) {
        self.name = name
    }
}


var people = [Person(named: "Paris"), Person(named: "Tim"), Person(named:"Mars")]

//: Now we can make new classes that inherit, or even selectively override, behaviours and attributes of a class we or others have made. This is done by declaring a **superclass** that your class inherits from alongside its class name.
class Speaker: Person {
    
    var talks: [Talk]
    
    init(named name: String, presenting talks: [Talk]) {
        self.talks = talks      // initialise the values you need in this specialisation
        super.init(named: name) // defer the rest to the superclass's initialiser if you wish
    }
    
    // you can make as many initialisers as you want, allowing default values or custom implementations
    override init(named name: String) {
        self.talks = []
        super.init(named: name)
    }
}

people.removeAll()

people = [
    Speaker(named: "Paris", presenting: talks),
    Speaker(named: "Tim", presenting: talks),
    Speaker(named: "Mars", presenting: [swiftTalk])
] // still okay because they're still all Person types

//: Sometimes we want to add something to a class or struct declared elsewhere. Good thing we have **extensions**. They cannot contain stored properties, but they can contain **computed** properties and additional functions, even define class-specific operators. They're also a tidy way to separate visually the parts of a class that handle different aspects or behaviours, or to represent evolution during development.

extension Speaker {
    
    var workload: Int {
        return self.talks.count
    }
    
    func acceptTalk(named talkName: String) {
        
        // get the first talk with a name that matches
        var acceptedTalk = self.talks.filter { $0.name == talkName }.first
        
        // accept it
        acceptedTalk?.accepted = true
    }
    
    static func ==(lhs: Speaker, rhs: Speaker) -> Bool {
        return lhs.name == rhs.name
    }
}

//: You can extend almost everything in Swift, including the base types.
extension Int {
    var doubled: Int
    {
        return self * 2
    }
}

6.doubled

//: Another handly use of extensions is to retain freebies. Remember that we said a default member-wise initialiser is made for a struct **if you do not declare a custom one**. Actually, it is made as long as you do not declare a custom one **in the initial declaration block**. This means you can *extend* a struct to give it a custom initialiser while retaining the inferred (free) one.

extension Talk {
    
    init(accepted: Bool) {
        self.init(name: "Untitled Talk", accepted: accepted)
    }
    
    init() {
        self.init(accepted: false)
    }
}

let blockchainTalk = Talk(name: "Block-by-Blockchain", accepted: false)
let lightningTalk = Talk(accepted: true)
let otherTalk = Talk()

/*:
 Properties can also be given **observers**, that will perform some action when they are about to or were just changed. This can be useful when other variables and actions need to be kept notified of changes.

Note that property observers don't fire for initialisation, only the first change afterwards.
*/

// making some type that handles some state
enum Status: String {
    
    case active = "Active"
    case testing = "Testing"
    case inactive = "Inactive"
    
    var message: String {
        
        switch self {
            
            case .active:
                return "Operating as normal."
            
            case .testing:
                return "Testing conditions."
            
            case .inactive:
                return "Operation will return sometime in the future."
        }
    }
}

// making some type that handles notification of state
class MessageBus {
    
    func post(message: String) {
        print("Message posted to the channel: \"\(message)\"")
    }
}

// making the type thay actually handles change and notification delegation
class DataModel {
    
    let id: String
    let bus: MessageBus
    
    var status: Status = .active {
        willSet(newValue) {
            self.bus.post(message: "Status will change to \(newValue.rawValue) from \(status.rawValue).")
        }
        
        didSet {
            self.bus.post(message: "Status was changed to \(status.rawValue) from \(oldValue.rawValue). \(status.message)")
        }
    }
    
    init(id: String, bus: MessageBus) {
        self.id = id
        self.bus = bus
    }
}

let bus = MessageBus()
let model = DataModel(id: "404D765E-73B8-4475-BD4A-713246B00389", bus: bus)
//model.status = .inactive

//: Swift has two main types (of types): value and reference types. Classes are **reference** types, which are shared instances whose modifications are shared. Structs, enums and Tuples are **value** types, which are separate instances who will suffer changes independently (effectively, minus some compiler optimisation). For example, a reference type:

class ClassType { // we make a reference-typed thing
    var foo: Int = 0
}

var classVariable = ClassType() // we instantiate a thing

let classDuplicate = classVariable // we "duplicate" the thing

classVariable.foo = 5 // we change its value

classDuplicate.foo // its duplicate is also changed, as it is just a variable that refers to the same object
//: ...versus a value type:
struct StructType { // we make a value-typed thing
    var bar: Int
}

var structVariable = StructType(bar: 0) // we instantiate the thing

let structDuplicate = structVariable // we duplicate the thing

structVariable.bar = 5 // we change its value

structDuplicate.bar // the duplicate is not changed, it is a separate entity

//: Up Next: **Enumerations**!. Enums are a personal favourite in the Swift language; they are not just a list of possible related values like in other languages, they can store alternative values, attributes, functions and all sorts of things.
enum DayType {
    case weekday, weekend
}

enum Day: String { // you can "extend" a type to give each value a "rawValue" of that Type
    
    case sunday     = "Sunday"
    case monday     = "Monday"
    case tuesday    = "Tuesday"
    case wednesday  = "Wednesday"
    case thursday   = "Thursday"
    case friday     = "Friday"
    case saturday   = "Saturday"
    
    var type: DayType {
        
        switch self {
            
            case .saturday, .sunday:
                return .weekend
            
            default:
                return .weekday
        }
    }
    
    // TODO UPDATE THIS (BELOW) FOR SWIFT 5.1
    // this is silly, but in Swift 4.2 getting an array of cases is built in! :D :D :D
    var cases: [Day] {
        
        return [.sunday, .monday, .tuesday, .wednesday, .thursday, .friday, .saturday]
    }
    
    func increment(days number: Int) -> Day {
        
        let days = self.cases
        var index = days.firstIndex(of: self) ?? 0
        index += number % days.count
        
        return days[index]
    }
    
    mutating func nextDay() {
        self = increment(days: 1)
    }
}

var day = Day.sunday

day.rawValue
day.type
day.nextDay()
day.increment(days: 4)

/*:
 Enums can also be given associated values, allowing different cases to each store different values. This means they will have to be instantiated with a parameter and these types cannot have rawValues. Here is an example of how decisions can then be made not only on the different cases but also their associated values.
 */

enum Vehicle {
    
    case car(registration: String?)
    case bicycle
    
    
    var allowedOnRoad: Bool {
        
        switch self {
            
            case .car(registration: nil):   // cars with no registration code
                return false
            
            default:                        // bicycles and also cars with a registration code
                return true
        }
    }
}

let vehicle1: Vehicle = .car(registration: nil)
vehicle1.allowedOnRoad

let vehicle2: Vehicle = .car(registration: "PLAT3NUMB3R")
vehicle2.allowedOnRoad

/*:
 # Protocols
 
 Sometimes you know you will have an object but, much like we said with the need for optional variables, you can't be sure what it will be exactly. It could be that you don't know what it is yet but you know what it will need to do, or that it could be one of multiple different but similar things that should be treated the same in this context. In comes **protocols**, one of the coolest things about the Swift language. This is much like an Interface in other languages, there are high-level declarations for other things to adhere to.
 
 Many argue that despite it being possible to program in Swift using entirely Object-Oriented approaches, it is in fact its most powerful when regarded as a protocol-based language. Let's look at some of the cool stuff you can do with the use of protocols...
 */

protocol Describable {
    
    func describe() -> String
}

protocol Renamable {
    
    var name: String { get set }
    
    func changeName(to: String, authorised: Bool)
}

/*:
 Using a protocol is similar to inheriting from a class, it just goes at the top of the declaration. To differentiate, protocols will often be named as an adjective (e.g. something-able) to differentiate that it is a declaration of ability, whereas superclasses will often be named as a noun (e.g. thing), but this is not enforced.
 
 Stylistically, separating these out into separate class extensions for each adherence keeps your files clean and makes it simpler to trace which protocol each value or function exists to adhere to.
 */

extension Person: Describable {
    
    func describe() -> String {
        return "A person named \(self.name)."
    }
}

extension Person: Renamable {
    
    func changeName(to newName: String, authorised: Bool) {
        
        if authorised {
            self.name = newName
        }
    }
}

//: Combining the concept of a protocol and an extension, we can declare default implementations for protocol requirements that will be used if an adhering entity does not override it.
extension Renamable {
    mutating func changeName(to newName: String, authorised: Bool) {
        
        if authorised {
            self.name = newName
        }
        
        if self.name == "" {
            self.name = "John Doe"
        }
    }
}

//: You can also specify constraints for where this will apply.
extension Describable where Self: Renamable {
    
    func describe() -> String {
        return "A thing named \(self.name), however this may have not always been the case."
    }
}

extension Array where Element: Describable {
    
    func describe() -> String {
        var description = "A collection of \(self.count) things named:"
        
        for element in self {
            description += "\n\(element.describe())"
        }
        
        return description
    }
}

people.describe()

extension Int: Describable
{
    func describe() -> String {
        return "\(self)"
    }
}

[1,4,5,2,7].describe()

//: A little tidbit is a nice way to clean up debugging: the CustomDebugStringConvertible protocol, adhering to which will require your class to have a debugDescription variable, but which will let you customise the description that appears for it in the line results.
extension Speaker: CustomDebugStringConvertible {
    
    var debugDescription: String {
        return "A Person that speaks"
    }
}

people.first // same as people[0]

//: Back to protocols in general. Using them, we can safely declare and interact with objects based on values and behaviours we have now declared the *will* have. Here, we can write a function that only requires its input be Renamable. This will work with our Person or Speaker classes, but it would also work with anything else that conformed to the Renamable protocol.

func changeNamesEnMasse(from originals: [Renamable], to newName: String) {
    for thing in originals {
        thing.changeName(to: newName, authorised: true)
    }
}

changeNamesEnMasse(from: people, to: "Human Name") // remember this is an array of Speaker types
// but Speaker types are Person types and Person types are Renamable

people.describe()

/*:
 # I/O and Debugging
*/

//: We can get a file from online.
// we'll make a structure to put it in
struct User: Codable
{
    let id: Int
    let username: String
    let email: String
}

// we need a decoder for the JSON data we're pulling in
let jsonDecoder = JSONDecoder()
var jsonIn: Data
var users: [User]? = nil

// specify the url of the file you want to download
if let url = URL(string: "https://jsonplaceholder.typicode.com/users") {
    
    // attempt to read page with your given contents from it
    if let json = try? Data(contentsOf: url) {
        
        jsonIn = json
        
        // decode it into our struct
        users = try? jsonDecoder.decode([User].self, from: jsonIn)
    } else {
        
        print("ERROR: File was unable to be retrieved from online!")
    }
} else {
    print("ERROR: URL was unable to be formed!")
}

// then perform the song and dance to un-optional everything, or just see values when needed
users?.first?.email

/*:
 "Debugging" with:
 
 * value tracing
 * print statements
 
 That might not seem like much, but spot the difference when tracking the behaviour of a function as simple even as the one below, when using these techniques versus without.
 */
func decreasingRandomNumbers(numbering count: Int, upTO limit: Int) -> [Int] {
    
    var limit = limit
    var margin: Int
    var random: Int
    var numbers: [Int] = []
    
    
    for _ in 1...count {
        
        random = Int.random(in: 0 ... limit) // generate random number between 0 and limit
        numbers.append(random) // put it in the list
        
        //print("New number generated: \(random)")
        
        margin = limit / 10 // get the top 10% of the available outcomes
        
        if random >= limit - margin { // if random was in the top 10%
            
            //print("Inner block was entered because random number was max possible. Decrementing limit by \(margin) (from \(limit) to \(limit - margin))")
            limit -= margin // lower the limit by 10%
        }
    }
    
    return numbers
}


decreasingRandomNumbers(numbering: 100, upTO: 100)

/*:
 # Question Time and Extras
 
 ## Resources and Further Questions
 
 Feel free to direct any further questions we don't get time for to us on Twitter!
 
 [**@parisba**](https://twitter.com/parisba) | [**@The_McJones**](https://twitter.com/The_McJones) | [**@TheMartianLife**](https://twitter.com/TheMartianLife)

 
 ## Related Links
 
 * [Swift.org's Language Documentation](https://docs.swift.org) => **docs.swift.org**
 
 * [Learning Swift 3rd Edition](http://shop.oreilly.com/product/0636920083566.do) => **lab.to/learning-swift-3e**
*/