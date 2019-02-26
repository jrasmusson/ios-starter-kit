# Protocol Oriented Programming

Swifter's have three beefs with OO class oriented programming.

### 1. Implicit sharing 

By sharing state among objects and instances you run into all sorts of problems.
* Defensive copying
* Inefficiency
* Expense
* Race conditions
* Locks
* More inefficiency tracking locks
* Deadlock
* Complexity
* Bugs!

One side effect of NSArray in Objective-C is that arrays are passed by reference. Which means when you modifiy an array in Objective-C all the classes sharing that reference are modified. Which is why ObjC has so much defensive copying and you always copy an array when passing it from one class to another. 

All Swift based collections are structures. Which means you get a new copy of an collection every time you use it. And you don't need to worry about modifying a collection when iterating through it like you do in ObjC.

Values don't share. Classes over share. That's what is meant by value structured programming.

### 2. Inheritance is very heavy and invasive.

* You inherit all the property types
* Leads to *initialization burden* 
* Have to make sure you don't *break the super class invariants*. 
* Must know what/how to override and what not to

### 3. Lost type relationships 




## Inheritance

There are two ways you can do inheritance in swift.

### Class based inheritance

```swift
class ActivationService {

    func handle<T: Codable>(response: DataResponse<Data>, completion: @escaping (T?, Error?) -> ()) {
        switch response.result {
        case .success:
	        completion(result, error)
        case .failure(let error):
            completion(nil, error)
        }
    }
    
}
```

### Protocol based inheritance

```swift
protocol ActivationService {

}

extension ActivationService {

    func handle<T: Codable>(response: DataResponse<Data>, completion: @escaping (T?, Error?) -> ()) {
        switch response.result {
        case .success:
	        completion(result, error)
        case .failure(let error):
            completion(nil, error)
        }
    }

}
```

The advantage of protocal based inheritance non-class types (like structs) are the following

* you don't lose your single inheritance - its still there if you need it
* you can compose objects through protocols as opposed to inheriting functionality
* you can be more nuanced in how you apply that new functionality

The second point here is the big one. Instead of using inheritance as the means of sharing funcationality you compose it.

For example with single inheritance based languages you can't go

```swift
class SomeClass: Inherit1, Interit2, Inherit3 {
    // Boom! Only single inhertiance allowed
}
```

But with protocol based inheritance you can.

```swift
class SomeClass: Protocol1, Protocol2 {

protocol Protocol1 {

}

extension Protocol1 {
	func one() { // impl }
}

protocol Protocol2 {

}

extension Protocol2 {
	func two() { // impl }
}
```

### Links that help

* [Protocol Oriented Programming - WWDC 2015](https://developer.apple.com/videos/play/wwdc2015/408/)
* [Type Values in Swift - WWDC 2015](https://developer.apple.com/videos/play/wwdc2015/414/)
* [Protocol and Value Oriented Programming in UIKit Apps - WWDC 2016](https://developer.apple.com/videos/play/wwdc2016/419/?time=340)
* [Unit testing with protocols](https://riptutorial.com/swift/example/8271/leveraging-protocol-oriented-programming-for-unit-testing)
