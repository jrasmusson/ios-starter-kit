# Protocol based inheritance

There are two ways you can do inheritance in swift.

## Class based inheritance

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

## Protocol based inheritance

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

* [Protocol Oriented Programming - WWDC](https://developer.apple.com/videos/play/wwdc2015/408/)
* [Type Values in Swift - WWDC](https://developer.apple.com/videos/play/wwdc2015/414/)
* [Unit testing with protocols](https://riptutorial.com/swift/example/8271/leveraging-protocol-oriented-programming-for-unit-testing)
