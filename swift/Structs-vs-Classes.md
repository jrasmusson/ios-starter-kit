Structures and classes are the basic building blocks of code in Swift. In general, structs and protocols are preferred to building everything with classes. Mostly because structs are simple, are value only, and have no identify or reference.

Enums, structs, and classes can all be used to represent data.

![Types of data](https://github.com/jrasmusson/ios-starter-kit/blob/master/swift/images/types-of-data.png)

And all can implement protocols.

![Protocols](https://github.com/jrasmusson/ios-starter-kit/blob/master/swift/images/protocols.png)

Which leads one to wondering when to use which. Here are some guidelines.
* Use structures by default
* Use classes when you need Objective-C interoperability
* Use classes when you need to control the identity of the data you are modeling
* Use structures along with protocols to adopt behavior and share implementation

## Choose Structures by Default
Use structures to represent common kinds of data. Numbers, strings, arrays, and dictionaries in Swift are all modelled from structures. Meaning they have no identity.

Using structures makes it easier to reason about your code. Local changes aren’t visible to the rest of your app. You are working with values and you don’t need to worry so much about what this instance of your object is doing because it’s just dumb data.

## Use Classes When you Need Objective-C Interoperability
Because you will need to periodically extend Objective-C classes when building your apps, to do so you will need to extend and inherit as a class. Often by prefixing your variables with the @objc key word.

## Use Classes When You Need Identity
There are very few cases when you need to share identify across your whole app. But a few of them are:
File handlers
Network connections
Database connections
Anything where state needs to be shared

These are all good examples of when to use a class. For everything else just use structs and enums as data.

## Use Structures When You Don’t Control Identity
When you read data from an external website you don’t control that data. Someone else does. So read it in as value data. 

```swift
struct User {
    let myID: Int
    var nickname: String
}

var myRecord = try JSONDecode().decode(User.self, from: jsonResponse)
```


## Use Structures and Protocols to Model Inheritance and Share Behavior

In other language inheritance and composition are the default ways to share behavior. In Swift we do this through protocols and structures.

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


Links that help
* https://developer.apple.com/documentation/swift/choosing_between_structures_and_classes
* https://medium.com/@abhimuralidharan/all-about-protocols-in-swift-11a72d6ea354