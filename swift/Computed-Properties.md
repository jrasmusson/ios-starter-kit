# Computed Properties

## How to support optional computed property

Here the value we want to return, `wrappedValue`, is optional. And we don't want it to be. So we create a private var of a new variable, `height`, assign it a value, and then in the computeted property `get` and `set` the wrapped one which we really care about.

```swift
struct SmallRectangle {
    private var _height = 0
    private var _width = 0
    
    var height: Int {
        get { return _height.wrappedValue }
        set { _height.wrappedValue = newValue }
    }
    
    var width: Int {
        get { return _width.wrappedValue }
        set { _width.wrappedValue = newValue }
    }
}
 ```

### Links that help
* [Swift Properties](https://docs.swift.org/swift-book/LanguageGuide/Properties.html)
