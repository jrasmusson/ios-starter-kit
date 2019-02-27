# Properties

Properties are values associated with a particular class or structure. Unlike other languages, Swift encourages you to use and access properties directly.

## Stored Properties

These properties are stored directly in the class.

```swift
struct FixedLengthRange {
    var firstValue: Int
    let length: Int
}
```

## Computed Properties

Computed properties are _computed_ which means they don't have a backing variable. They don't store any variables directly, but they can change other variables that back them up.

```swift
var x:Int

var xTimesTwo:Int {
    set {
       x = newValue / 2
    }
    get {
        return x * 2
    }
}
```

`newValue` is the default variable name assigned in the getter. You can assign another if you like.

### Read-Only Computed Properites

These are getters with no setters. They must be `var`s. You can simplify the declaration of a read-only property  by removing the get keyword and braces.

```swift
struct Cuboid {
    var width = 0.0, height = 0.0, depth = 0.0
    var volume: Double {
        return width * height * depth
    }
}
```

## Lazy Stored Properties

A _lazy property_ is one where the initial value is not calculated until needed.

> Note: Lazy properties are always `var`s because of their delayed loading.

Lazy properties work best when the initial value dependent on outside factors whose values are not known until later.

```swift
class DataManager {
    lazy var importer = DataImporter()
    var data = [String]()
}
```

Lazy vars can also be computed properties. Very handy for when you want to access a class method but can wait until the var is loaded.

```swift
    lazy var button: UIButton = {
        makeButton()
    }()
```

## Property Observers

Respond to changes in a property's value. Can observe anything except `lazy` properties. 

```swift
class StepCounter {
    var totalSteps: Int = 0 {
        willSet(newTotalSteps) {
            print("About to set totalSteps to \(newTotalSteps)")
        }
        didSet {
            if totalSteps > oldValue  {
                print("Added \(totalSteps - oldValue) steps")
            }
        }
    }
}
```

## Type Properties

Instance properties are properites that belong to that one instance. Type properties belong to all instances of that type.

```swift
struct SomeStructure {
    static var storedTypeProperty = "Some value."
}
enum SomeEnumeration {
    static var storedTypeProperty = "Some value."
}
class SomeClass {
    static var storedTypeProperty = "Some value."
}
```

### Links that help

* [Apple docs](https://docs.swift.org/swift-book/LanguageGuide/Properties.html)


