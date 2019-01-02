# Inheritance

## Overriding properties

Seems a bit strange at first but the way you override properities is to defined a stored property and then override it with a computed property.

```swift
class ActivationService {

    var url: String = ""
```

```swift
class OrderDetailsService: ActivationService {

    override var url: String {
        get {
            return "https://foo/bar"
        }
        set {
            // nop
        }
    }
```

It needs to be a `var`. You need to override the `get` and the `set`. And if you don't want to override the setter you can just define a getter in the base class like this.

```swift
class ActivationService {

    var url: String {
        get {
            return ""
        }
    }
```

*Note: You can't override a stored property with another stored property. Swift doesn't let you do that. What you can do however is switch from a stored property to a computed property. In otherwords just provide a different getter implementation. It's a subtle but important point.*


### Links that help

* [Inheritance](https://docs.swift.org/swift-book/LanguageGuide/Inheritance.html)

