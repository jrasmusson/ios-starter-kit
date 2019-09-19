# Enumerations

## You can set enums like properties on a class

```swift
class Tile {
    enum StatusState {
        case loading
        case loaded
        case failed
        case delinquent
    }
    
    var status: StatusState {
        didSet {
            switch status {
            case .loading: loadingState.isHidden = false
            case .loaded: loadedState.isHidden = false
            case .failed: failedState.isHidden = false
            case .delinquent: delinquentState?.isHidden = false
            }
        }
    }
}
```

This is much better than having x4 `Bool`s. Enums are good at encapsulated and switching on state.

## What is enum

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

    public init(chatType: ChatType) { ... }

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

// or

enum EmployeeType: String {
    case Executive
    case SeniorManagement = "Senior Management"
    case Staff
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

## Associated values

Something cool you can do with enums is pass along data - we call these associated values.  For example say we have a control that can be configured one of two ways.

```swift
public class StandardEntryView: UIView {
    
    public enum Kind {
        case email(showHeaderView: Bool)
        case listSelection(showHeaderView: Bool, pickerTitle: String, list: [(String, Any)])
    }

    public let kind: Kind

    public init(kind: Kind = Kind.email(showHeaderView: false)) {
        self.kind = kind
        super.init(frame: .zero)
        commonInit()
    }
    
```

By defining an enum, with assoicated values, we can pass data along with our enum and use that data in those switch cases. The `let showHeaderView` is how how unwrap associated values when we access in the switch.

```swift
    func commonInit() {

        let showHeader: Bool

        switch kind {
        case .email(let showHeaderView): // unwrapping the associated value
            showHeader = showHeaderView
        case .listSelection(let showHeaderView, _, _):
            showHeader = showHeaderView
        }

    }
```

Use don't have to use the associated values when you switch on them

```swift
        switch kind {
        case .email:
            textField = UITextField()
        case .listSelection:
            textField = NoCaratNoTypingTextField()
        }
```

And if you don't care about certain values you can just ignore them.

```swift
        switch kind {
        case .email:
            break
        case .listSelection(_, let pickerTitle, let listItems):
            break
        }
```
## Enums with methods

```swift
enum WeekDay :String {
    case Monday
    case Tuesday
    func day() ->String { return self.rawValue }
}
print(WeekDay.Monday.day()) // prints Monday
```

Important: Enums can have methods, subscripts, and computed properties. But it cannot have stored properties.

## Enums are more powerful than you think

### How to add an enum to an existing struct

Say you want to have a struct return an enum based on an internal type.

```swift
enum ActivationModemType: String {
    case hayes
    case usRobotics
    case unknown
}

struct OrderItem {
    let modemType: String
}

extension OrderItem {
    // computed getter
    public var activationModemType: ActivationModemType {
        guard let modemType = modemType, let returnValue = ActivationModemType(rawValue: modemType) else {
            return ActivationModemType.unknown
        }
        return returnValue
    }
```

You use the internal variable (`modemType`) to dynamically figure out the enum in the computed getter, and then return that enum value.

### Enums can be used as types

Enums don't just have to be used for switch statements. They, along with their associated values, can be more more akin to objects and structures themselves. For example here is an example of how a struct where one of it's types is an Enum.

```swift

import Foundation

struct ActivationResourcePackage {
    let headerImageName: String
    let list: [ListType]
}

enum ListType {
    case checkmark(header: String, subheader: String)
    case url(title: String, url: URL)
    case appDownload(title: String, subheader: String, buttonTitle: String, appUrl: URL)
}

extension ActivationResourcePackage {
    static var usRoboticsPackage = ActivationResourcePackage(headerImageName: "robot-pink", list: [
        ListType.checkmark(header: "Pat your head", subheader: "This helps the intertubes do their magic."),
        ])

    static var hayesPackage = ActivationResourcePackage(headerImageName: "robot-pink", list: [
        ListType.checkmark(header: "Rub your belly", subheader: "Getting hungry for that internet goodness!"),
        ListType.checkmark(header: "That's it!", subheader: "Don't forget to have a good day."),
        ])
}
```

Couple of cool things going on here:

1. Enums are being used as a type (i.e. `ListType`).

This is an enum, but it has parameters (associated types), and it is used as a type in an array. Like a struct or a class.

2. Structs can have concrete static types.

You can create a struct, and then statically give it type safe configurations, or representations, of what that struct represents. Handy for configuration, encapsulating differences, and exposing in a type safe way.

Then you can use all these later in switch statements like this.

```swift
private func createPackage(for orderItem: OrderItem) -> ActivationResourcePackage {

    switch orderItem.activationModemType {
    case .usRobotics:
        return ActivationResourcePackage.usRoboticsPackage
    case .hayes:
        return ActivationResourcePackage.hayesPackage
    case .unknown:
        return ActivationResourcePackage.unKnowPackage
    }

}
```

Here we are creating a type safe package representing our configuration, based on an enum type.

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

### Extensions can't contain stored properties

```swift
extension OrderItem {
    // lazy stored property
    lazy var activationModemType: ActivationModemType = {
        let activationModemType = ActivationModemType.hayes
        return activationModemType
    }()
```

### But they can contain computed properties

```swift
enum ActivationModemType: String {
    case hayes
    case usRobotics
    case unknown
}

extension OrderItem {
    // computed getter
    public var activationModemType: ActivationModemType {
        guard let modemType = modemType, let returnValue = ActivationModemType(rawValue: modemType) else {
            return ActivationModemType.unknown
        }
        return returnValue
    }
```

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
