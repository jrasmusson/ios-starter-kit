# Optionals
A short summary of things to know about Optionals when programming in Swift.

# What are Optionals?

Optionals are Swifts way of dealing with null and nils. Instead of polluting your code with if null checks, Swift Optionals are a more elegant way to check if an objects value hasn’t been set, and letting you deal with gracefully.

One way to think of an Optional is as a wrapper. It wraps what is contained within. The wrapper can contain something or it can be empty.

This Optional contains a 4

```swift
let myOptional: Int? = 4
```

While this one contains nothing (or a nil).

```swift
let myOptional: Int? = nil
```

Optional is just a type in Swift. Int and Int? (optional Int) are two different types. Under the hood an Optional is merely an enum with two cases. None meaning no value is set and Some meaning there is an underlying value associated.

```swift
enum Optional<T> {
    case None
    case Some(T)
}
```

```swift
// these two statements are exactly the same
let x: String? = nil
let x = Optional<String>.None

// these two statements are exactly the same
let y: String? = "Hi there"
let y = Optional<String>.Some("Hi there")
```

So that's what Optionals are. But before we can use in Options internal value, we first need to unwrap it.

# How do they work?
There are three way to unwrap an Optional
 - Forced Unwrapping
 - Optional Binding
 - Implicit Unwrapping

### Forced Unwrapping
Forced unwrapping is the brute force way to get an an underlying Optional. You basically take your Optional, end it with an “!”, and you get direct access to the internal contents of the Optional.

```swift
let optionalInt: Int? = 5
let unwrappedInt: Int = optionalInt! // OK because Int? has a value
```

This works so long as your Optional has an underlying value. The downside to force unwrapping is your program will crash if the Optional doesn’t have an underlying value. 

If your force unwrap and your Optional doesn’t have a value, and exception is raised

```swift
// under the hood forced unwrapping is a switch statement
switch b {
    case .Some(let value): a = value
    case .None: //raise an exception
}
```
For this reason **forced unwrapping is strongly discouraged**. The Swift way to access an Optionals internal values is through Optional Binding.

### Optionally Binding
Optional binding takes your Optional, extracts it’s underlying value, and returns it to you all in one single action.

```swift
let optionalInt: Int? = 5

if let constantInt = optionalInt {
    print("optionalInt has an integer value of \(constantInt).")
} else {
    print("optionalInt is nil")
}

// will print "optionalInt has an integer value of 5"
```

If the value exists, you get it in the form of whatever variable you define. If it doesn’t you can gracefully deal with it in the else side of the if.

The main thing to note here is that the variable you get back (constantInt in this case) is only valid within the scope of the if statement.

```swift
if let constantInt = optionalInt {
    // constantInt only in scope here
} 
```

There is another type of statement, called a Guard clause that unwraps and makes the variable in scope for the rest of the method

```swift
guard let url = URL(string: string) else {
    return
}

// url in scope out here
```

### Implicit unwrapping
If you don’t like all this Optional stuff, and you just want to use a variable out of the box like we used to do in the old days, you can. It’s called Implicit unwrapping. 

```swift
// implicitly unwrapped optional
let assumedInt: Int! = 123
let implicitInt: Int = assumedInt
```

This is kind of like saying: “Unwrap this guy once and use the value anywhere you want.”

Just be careful. An implicitly unwrapped variable that is set to nil will crash your program if accessed. So use wisely be sure to initialize your variable upon creation.

Here are some other cool Optional things to be aware of.

## Nil coalescing

To set a default value for an Optional that's nil use the double question mark '??' syntax for Nil Coalescing.

```swift
let result = optionalInt ?? 0
```

This just means if the Optional is nil, use this default value.

## Optional Chaining
Optional chaining is a feature that allows you to call properties and methods on an optional that might currently be nil. Unlike force wrapping however which would result in a runtime error, optional chaining fails gracefully when the optional is nil.

```swift
class Person {
    var bankAccount: BankAccount?
}

class BankAccount {
    var balance: Int
}

let person = Person()

if let currentBalance = person.bankAccount?.balance {
    print("Person has a bank account and its balance is \(currentBalance)")
} else {
    print("Person has no bank account")
}

// prints "Person has no bank account"
```
### Links that help

* [Optionals explained simply](https://hackernoon.com/swift-optionals-explained-simply-e109a4297298)
* [Swift Basics](https://docs.swift.org/swift-book/LanguageGuide/TheBasics.html)


