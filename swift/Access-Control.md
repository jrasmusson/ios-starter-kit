# Access Control

```swift
public class SomePublicClass {}
internal class SomeInternalClass {}
fileprivate class SomeFilePrivateClass {}
private class SomePrivateClass {}
public var somePublicVariable = 0
internal let someInternalConstant = 0
fileprivate func someFilePrivateFunction() {}
private func somePrivateFunction() {}
```

Default is internal

```swift
class SomeInternalClass {}              // implicitly internal
let someInternalConstant = 0            // implicitly internal
```

Public - anyone can use
Internal - within that module (default)
File-private - within that file
Private - the classes and sub entities



### Links that help

* [Swift Lanaguage Guide - Access Control](https://docs.swift.org/swift-book/LanguageGuide/AccessControl.html)

