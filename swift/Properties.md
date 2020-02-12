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

### Property Observers

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

## Computed Property as closure

Usefull for when you have complicated setup.

```swift
    var foo: Int = {
        return 1
    }()
```

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

```swift
    lazy var headerView: ActivationHeaderView = {
        return ActivationHeaderView(activationResourcePackage: activationResourcePackage)
    }()
```

`lazy` enables class to initialize other resources first, so we can use later in initialization.

## set (Computed) or didSet (Stored)? 

Use `set` when the property you are setting is undering a transformation.

```swift
var xTimesTwo:Int {
    set {
       x = newValue / 2
    }
}
```

Use `didSet` for after the fact processing. Or as swift likes to describe it observing.

```swift
var daysPastDue:Int {
    didSet {
       // update label
    }
}
```

## Conditional Initialization

Here is how you can define a variable as a `let`, but instantiated it's value based on logic.

```swift
let entryPoints: [String]

if Chat.shared.hasFailedActivation {
    entryPoints = ["fail"]
}
else {
    entryPoints = ["ios", "myapp"]
}

// or as ternary

let entryPoints = Chat.shared.hasFailedActivation ? ["fail"] : ["ios", "myapp"]
```


### Links that help

* [Apple docs](https://docs.swift.org/swift-book/LanguageGuide/Properties.html)


