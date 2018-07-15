# Protocols
A protocol defines a blueprint of methods, properties, and other requirements that suit a particular task or piece of functionality. The protocol can then be adopted by a class, structure, or enumeration to provide an actual implementation of those requirements. Any type that satisfies the requirements of a protocol is said to conform to that protocol.

## Protocol Syntax

```swift
protocol SomeProtocol {
    // protocol definition goes here
}
```
Classes , structs, enums can adopt these protocol by placing protocol’s name after the type’s name, separated by a colon, as part of their definition. Multiple protocols can be listed, and are separated by commas:

```swift
struct SomeStructure: FirstProtocol, AnotherProtocol {
    // structure definition goes here
}
```

If a class has a superclass, list the superclass name before any protocols it adopts, followed by a comma:

```swift
class SomeClass: SomeSuperclass, FirstProtocol, AnotherProtocol {
    // class definition goes here
}
```

You might have already seen `UIViewControllers` implementing `UITableview` `datasource` and `delegate` protocols.

```swift
class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate { }
```

Although, the best practice is to group this in a separate extension of ViewController and implement the protocols.

```swift
class ViewController: UIViewController {}
extension ViewController: UITableViewDataSource, UITableViewDelegate
{
//implement protocol methods ands variables here..
}
```

## Adding Properties to Protocols
* A protocol can have properties as well as methods that a class, enum or struct conforming to this protocol can implement.
* A protocol declaration only specifies the required property name and type. It doesn’t say anything about whether the property should be a stored one or a computed one.
* A protocol also specifies whether each property must be gettable or gettable and settable.
* Property requirements are always declared as variable properties, prefixed with the `var` keyword.
* Gettable and settable properties are indicated by writing `{ get set }` after their type declaration, and gettable properties are indicated by writing `{ get }`.

```swift
protocol SomeProtocol {
    var mustBeSettable: Int { get set }
    var doesNotNeedToBeSettable: Int { get }
}
```
Static (or type properties) are indicated by the `static` or `class` keyword.

```swift
protocol AnotherProtocol {
    static var someTypeProperty: Int { get set }
}
```
## What is means to conform to a protocol

Here, we declared a protocol named FullyNamed . It has a gettable stored property called fullName of type string .

```swift
protocol FullyNamed {
    var fullName: String { get }
}
struct Person: FullyNamed {
    var fullName: String {}
}
let john = Person(fullName: "John Appleseed")
// john.fullName is "John Appleseed"
```

Now, we are defining a struct called Person and we are saying that the struct confirms to the FullyNamed protocol. This means that we should implement the fullName string variable inside the struct defined. Otherwise it will throw an error on us.

We can also define the fullName property as a computed property.

```swift
protocol FullyNamed {
    var fullName: String { get }
}
struct Person: FullyNamed {
    var fullName: String {
        return "John Appleseed"
    }
}
let john = Person()
// john.fullName is "John Appleseed"
```

## Method Requirements
As mentioned earlier, protocols can have methods as well.

* A protocol can have type methods or instance methods.
* Methods are declared in exactly the same way as for normal instance and type methods, but without curly braces or a method body.
* Variadic parameters are allowed.
* Default values are not allowed.
* Always prefix static (type) method requirements with the `static` keyword when they are defined in a protocol. Do this in both the protocol and the implementation.

```swift
protocol MethodRequirements {
    func someMethod()
    func someMethodWithReturnType() -> String
    static func someStaticMethod(variadricParam:String...)
}

struct SomeStruct: MethodRequirements {
    func someMethod() {
        print("someMethod called")
    }
    func someMethodWithReturnType() -> String {
        print("someMethodWithReturnType called")
        return "Hello"
    }
    static func someStaticMethod(variadricParam: String...) {
        print("someStaticMethod variadric called")
        print(variadricParam)
    }
}
```
Note: You can define and implement static method using either the static or class keyword. Both work.

```swift
static func someStaticMethod(variadricParam:String...)
class func someStaticMethod(variadricParam:String...)
```
## Protocols with mutating methods
Mutating methods are methods we use on value types like structs and enums. These methods are allowed to modify the instance it belongs to and any properties of that instance.

Here is an example of how mutating works with a structure (no protocol yet).

```swift
struct Rectangle {
    var height: 1
    var width: 1
    
    func area() -> Int {
        return width * height // doesn't modify
    }
    
    mutating func scale(by multiplier: Int) {
        height *= multiplier
        width *= multiplier  // modifies
    }
}
```
With methods, if you mark a protocol instance method requirement as mutating, unlike static and type methods, you do not need to write the mutating keyword when writing the implementation of that class. The mutating keyword is only used by structures and enumerations.

Here for example we see an enum requiring the mutating keyword on it’s Toggable implementation, but following it a class implementation that does not.

```swift
protocol Togglable {
    mutating func toggle()
}

enum OnOffSwitch: Togglable {
    case on, off
    mutating func toggle() {
        switch self {
        case .on:
            self = .off
        case .off:
            self = .on
        }
    }
}

var lightSwitch = OnOffSwitch.off // to mutate this needs to be a var
lightSwitch.toggle()

class BigSwitch: Togglable {
    var isOn = false
    func toggle() { // no mutating method keyword required
        isOn = !isOn
    }
}

let bigSwitch = BigSwitch()
print("bigSwitch isOn:\(bigSwitch.isOn)")
bigSwitch.toggle()
print("bigSwitch isOn:\(bigSwitch.isOn)")
```

## Initializer Requirements

Protocols can have constructors (initializers). These can be either designated or convenience initializers. In both cases you must mark the initializer with the required modifier.

```swift
protocol SomeProtocol {
    init(someParameter: Int)
}

class SomeClass: SomeProtocol {
    required init(someParameter: Int) {
        // initializer implementation goes here
    }
}
```

If a subclass overrides, you must mark the initializers with both the `required` and `override` modifiers.

```swift
protocol SomeProtocol {
    init()
}

class SomeSuperClass {
    init() {
        // initializer implementation goes here
    }
}

class SomeSubClass: SomeSuperClass, SomeProtocol {
    // "required" from SomeProtocol conformance; "override" from SomeSuperClass
    required override init() {
        // initializer implementation goes here
    }
}
```

## Adding Protocol Conformance with an Extension

Extensions can add new properties, methods, and subscripts to an existing type. This is the preferred convention for adding functionality to an existing class (instead of implementing the protocol methods directly in the class).

```swift
protocol Growable {
    var age:Int { get }
}
class Human {
    var name: String
    init(name: String) {
        self.name = name
    }
}
extension Human: Growable {
    var age:Int {
        return 18
    }
}
var aHuman = Human(name: "John")
aHuman.age
```

## Declaring Protocol Adoption With An Extension

If a type already conforms to all the requirements of a protocol, but has not yet stated that is adopts that protocol, you can make it adopt to the protocol with an empty extension.

Types do not automatically adopt a protocol just by satisfying it’s requirements. They must always explicitly declare their adoption of the protocol.

```swift
class Animal {
    var age: Int {
        return 7
    }
}

extension Animal: Growable{}
```

## Protocol Inheritance

A protocol can inherit one or more other protocols. The syntax of protocol inheritance is similar to class inheritance.

```swift
protocol InheritingProtocol: SomeProtocol, AnotherProtocol {
    // protocol definition goes here
}
```

## Checking for Protocol Conformance
You can use the is and as operators to check for protocol conformance.

* The is operator returns true if an instance conforms to a protocol and returns false if it does not.
* The as? version of the downcast operator returns an optional value of the protocol’s type, and this value is nil if the instance does not conform to that protocol.
* The as! version of the downcast operator forces the downcast to the protocol type and triggers a runtime error if the downcast does not succeed.

## Optional Protocol Requirements

Protocols can have optional methods and properties.

Optional requirements are prefixed by the optional modifier. Optional requirements are available so you can write code that interoperates with Objective-C. Both the protocol and the optional requirement must be marked with the @objc attribute. Note that @objc protocols can be adopted only by classes that inherit from Objective-C classes. They can’t be adopted by structures or enumerations.

```swift
@objc protocol CounterDataSource {
    @objc optional func increment(forCount count: Int) -> Int
    @objc optional var fixedIncrement: Int { get }
}
```

# Protocol Extensions
Protocols can be extended to provide method and property implementations to conforming types. 

```swift
protocol Rotating {
    var rotates: Bool { get }
}

extension Rotating {
    var rotates: Bool {
        return true
    }
}

class Fan: Rotating {}
let fan = Fan()
fan.rotates
```

> Note: A conforming type implementation will override that in the protocol.

Links that help
* https://medium.com/@abhimuralidharan/all-about-protocols-in-swift-11a72d6ea354
* https://docs.swift.org/swift-book/LanguageGuide/Protocols.html


