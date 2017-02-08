//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"

class Dog {
    
    let breed: String
    var name: String?
    
    init(breed: String, name: String) {
        self.breed = breed
        self.name = name
    }
    
    init(breed: String) {
        self.breed = breed
    }
    
    func bark() -> String {
        return "Bark!"
    }
    
//    THIS IS BAD. USE FULL WORDS.
//    func spk(str: String) -> String {
//        return str
//    }
    
    func speak(string: String) -> String {
        return string
    }
    
}

let jessesDog = Dog(breed: "Soft-Coated Wheaten Terrior", name: "Floyd")
jessesDog.name = "Wally"
// jessesDog.breed = "Poodle" // not okay

let strayDog = Dog(breed: "Australian Cattle Dog")
strayDog.name

let x: Int = 5 // not as good
let y = 5 // good (Swift can guess we wanted an Int here)

// strayDog.name = x // not ok, x is Int and will always be an Int

let z = 10.0 // Double
z * Double(x) // Initialize new Double from x, then multiply
// this is not casting, you're creating a whole new Double object here

var mysteryDog: Dog? = Dog(breed: "Borzoi", name: "Goose")
print(mysteryDog)
print(mysteryDog?.name)

// safe unwrap, returns String?
let whatTheDogSaid = mysteryDog?.bark()

mysteryDog = nil

// unsafe unwrap, returns String or crashes if nil
// let whatTheDogSaidTheSecondTime = mysteryDog!.speak(string: "Woof!") // crashes

// if you feel like you have to use ! instead of ?,
// try structuring your code differently

// every ! is a place where your program can crash

// implicitly unwrapped Optional
// (there's usually a better way)
// "You always have a choice." –Optimus Prime
let exampleImplicitUnwrap: String!
// exampleImplicitUnwrap // crashes
exampleImplicitUnwrap = "Quickly assigned value"
exampleImplicitUnwrap // can treat this as non-Optional


// safely unwrapping Optional values
var someValue: String?
// ...
someValue = "Eventually assigned value"
// ...

// ugly (can technically still crash)
if someValue != nil {
    someValue! // ugh
} else {
    // someValue was nil
}

// pretty (no way this can crash)
if let value = someValue {
    value // yay (it's non-Optional)
} else {
    // someValue was nil
}

func doSomething() {
//    if let value = someValue {
//        // a super long thing of code
//        value
//    }
    guard let someValue = someValue else {
        // someValue was nil
        return
    }
    // someValue was not nil, let's keep going
    // a super long thing of code
    someValue
}

let exampleBool = true
let exampleOptionalBool: Bool? = false
if let example = exampleOptionalBool, exampleBool {
    print("Hooray!")
} else {
    print("Boo!")
}

// MARK: - Common Programming Tasks

// MARK: - For Loops

// C-style for loop, we don't do this anymore
//for (var i = 0; i < 100; i++) {
//    
//}

// Swift-style for loop (0-99) 100 times
for i in 0..<100 {
    print(i)
}

// (0-100) 101 times
for i in 0...100 {
    
}

// for when we don't need i
for _ in 0..<100 {
    
}

// MARK: - While Loops
var condition = true
var number = 0
while condition {
    // number++ // bad (and not supported)
    number += 1
    // number = number + 1 // fine, but weird
    if number == 100 {
        condition = false
    }
}

// MARK: - Collection Types

let friends = ["Joey", "Ross", "Chandler", "Monica", "Phoebe", "Rachel"]
// friends[0] = "Mike" // not ok, friends is constant

var stooges = ["Larry", "Curly", "Moe"]
stooges[1] = "Shep"

var dataThatHasNotLoadedInYet = [Dog]() // Jesse's way
var dataThatHasNotLoadedInYetMethod2: [Dog] = [] // Matt's way

var anyArray = [Any]()
anyArray.append(jessesDog)
let something = anyArray[0]
if something is Dog {
    print(something)
}

if let anotherSomething = something as? Dog {
    print(anotherSomething)
} else {
    // potential error handling
}

let forcedAnotherSomething = something as! Dog // very bad, can crash, sad!
// no chance for error handling here


//let obviousInt = 5
//obviousInt as? Double

// MARK: - Classes, Structs, Enums, and Protocols

// reference type
class SomeClass {
    var value: Int
    
    init(value: Int) {
        self.value = value
    }
}

// value type (used for modeling data)
// no inheritance
struct SomeStruct {
    var value: Int
}

// passes a reference on assignment
let a = SomeClass(value: 5)
let b = a // assignment
b.value = 10
a.value

// copies on assignment
var c = SomeStruct(value: 5)
var d = c // assignment
d.value = 10
c.value

enum Suit {
    case diamond
    case heart
    case spade
    case club
}

struct Card {
    let rank: Int
    let suit: Suit
}

let myCard = Card(rank: 2, suit: .heart)
switch myCard.suit {
case .diamond:
    print("It's a diamond!")
    // no need to break
case .heart:
    print("It's a heart!")
case .spade:
    print("It's a spade!")
case .club:
    print("It's a club!")
}

let foo = 5
switch foo {
case 1:
    print("One!")
case 2, 3, 4:
    print("Two, Three, or Five!")
case 5:
    print("Five!")
default:
    break
}










