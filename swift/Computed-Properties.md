# Computed Properties

## How to support non-optional computed property


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
