# Enumerations

Enumerations define a common type for a group of related values. They're valuable because they let you work with constants in a type-safe way. Unlike `enums` in other languages, enumberations in Swift are first class citizens. They can have computed values, methods, and can be more than just integers.

```swift
enum CompassPoint {
    case north
    case south
    case east
    case west
}

directionToHead = .south
switch directionToHead {
case .north:
    print("Lots of planets have a north")
case .south:
    print("Watch out for penguins")
case .east:
    print("Where the sun rises")
case .west:
    print("Where the skies are blue")
}
```

A `switch` statement must be exhaustive. If we left out `.west` the above code would not compile. When a case for every enumeration isn't possible, you can provide a `default` case to cover any cases not explicitly addressed.

```swift
let somePlanet = Planet.earth
switch somePlanet {
case .earth:
    print("Mostly harmless")
default:
    print("Not a safe place for humans")
}
```

> Note: Unlike C and Objective-C, Swift enumeration cases are not assigned a default integer value when created. Instead each enumeration case is a fully fledged value in it's own right, with an explicitly defined type.

### How to use enums

You can use enums are choose different functionality based on type. Instead of definining a int value to represent a flag or a boolean, you can simply define an enum.

```swift
enum ChatType {
    case authenticated
    case unauthenticated
}
```

And then use it in code to route functionality.

```swift
class NewChatViewController: UIViewController {

    let chatType: ChatType

    public init(chatType: ShawChatType) { ... }

    guard chatType == .authenticated else {
        return
    }
```

## Enums as strings

You can define enums as strings like this

```swift
enum SegueIdentifier: String {
    case Login
    case Main
    case Options
}
```

And then use like this

```swift
override func prepareForSegue(...) {
    if let identifier = segue.identifier ... {
        switch segueIdentifier {
        case .Login:
            ...
        case .Main:
            ...
        case .Options:
            ...
        }
    }
    
    SequeIdentifer.Main.rawValue // returns the `String representation`
}
```

## Compound enums

You can combine enums and access them like this

```swift
    public enum NetworkReachabilityStatus {
        case unknown
        case notReachable
        case reachable(ConnectionType)
    }

    public enum ConnectionType {
        case ethernetOrWiFi
        case wwan
    }
    
    open var isReachableOnEthernetOrWiFi: Bool { return status == .reachable(.ethernetOrWiFi) }

```
 
## Enums as errors

I like this way of styling errors with reasons (taken from [AlamoFireError](https://github.com/Alamofire/Alamofire/blob/master/Source/AFError.swift).

```swift
public enum AFError: Error {

    case invalidURL(url: URLConvertible)
    case parameterEncodingFailed(reason: ParameterEncodingFailureReason)
    case multipartEncodingFailed(reason: MultipartEncodingFailureReason)
    case responseValidationFailed(reason: ResponseValidationFailureReason)
    case responseSerializationFailed(reason: ResponseSerializationFailureReason)

    public enum ParameterEncodingFailureReason {
        case missingURL
        case jsonEncodingFailed(error: Error)
        case propertyListEncodingFailed(error: Error)
    }

    public var underlyingError: Error? {
        switch self {
        case .parameterEncodingFailed(let reason):
            return reason.underlyingError
        case .multipartEncodingFailed(let reason):
            return reason.underlyingError
        case .responseSerializationFailed(let reason):
            return reason.underlyingError
        default:
            return nil
        }
    }

}

extension AFError {
    /// Returns whether the AFError is an invalid URL error.
    public var isInvalidURLError: Bool {
        if case .invalidURL = self { return true }
        return false
    }
}

```


# Structures

Structures are general purpose constructs that form a key building block of your programs. `structs` in Swift are first class citizens - meaning they can contain functions, data, and pretty much anything else.

The main difference in Swift with `structs` and `classes` is to think of `structs` as value only objects. Meaning they are passed by value, have no identity, and should be treated more as value only objects. Which Swift encourages. Don't create a class unless your really need it. Instead work with `enums` and `structs`.

```swift
struct Resolution {
    var width = 0
    var height = 0
}
```

With `structs` you get a default initializers by for free (with classes you don't).

```swift
let vga = Resolution(width: 640, height: 480)
```

Structures can implement protocols, do protocol based inheritance, and pretty much anything a class can do.

```swift
// define the protocol
protocol Rotating {
    var rotates: Bool { get }
}

// give it a default implementation
extension Rotating {
    var rotates: Bool {
        return true
    }
}

// allow another struct or class to inherit
struct Fan: Rotating {}
let fan = Fan()
fan.rotates
```

> Note: Structures and enumerations are values types in Swift. Value types are _copied_ when assigned to a variable or constant, or passed into a function. All basic types in Swift - integers, floating point numbers, Booleans, strings, arrays, dictionaries - are all value types.


## Initializer Rules

All storied values in a `struct` must have a value by the end of the initializer. If they don't you'll get a compile error. The one exception is `Optionals`.

# Classes

Classes are like structures but one a couple of key differences. For one they have identify. They other is that they are passed by reference. 

What `classes` and `structs` have in common is both can: 

* define properties
* define methods
* define initializers
* be extended
* conform to protocols

Classes have the additional functionality of:

* inheritance
* type casting as runtime
* deinitializers
* multiple references pointing to the same instance of a class instance

```swift
struct Resolution {
    var width = 0
    var height = 0
}
class VideoMode {
    var resolution = Resolution()
    var interlaced = false
    var frameRate = 0.0
    var name: String?
}
```

## Identity Operators

Because classes are reference types, Swift has a special operator for comparing identity between two reference types.

* Identical to (`===`)
* Not identical to (`!==`)

Use these when comparing `classes`. Use `==` and `!=` for `structs` and `enums` as they are value types.


Links that help

* https://docs.swift.org/swift-book/LanguageGuide/Enumerations.html
