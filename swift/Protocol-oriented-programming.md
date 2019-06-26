# Protocol Oriented Programming

These are notes based on the following WWDC talk.

* [Protocol Oriented Programming - WWDC 2015](https://developer.apple.com/videos/play/wwdc2015/408/)

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

Classes are not a great fit for those design problems where type relationships matter. For example, if you have every tried to use classes for a symetric operation like comparison - for example general sort or binary search - you need a way to compare two elements.

With classes you end up with something like this.

```swift
class Ordered {
   func precedes(other: Ordered) -> Bool
}

func binarySearch(sortedKeys: [Ordered], forkey k: Ordered) -> Int {
   var lo = 0, hi = sortkedKeys.count
   while hi > lo {
      let mid = lo + (hi - loo) / 2
      if sortedKeys[mid].preceds(k) { lo = mid + 1 }
      else { hi = mid }
   }
   return lo
}
```

The problem is that is we need an implementation for every class method, and we don't know anything about the object type of `Ordered`. So we have to trap.

```swift
class Ordered {
   func precedes(other: Ordered) -> Bool { fatalError("implement me!") }
}
```

This is the first sign that we are fighting the type system. We tend to brush this warning aside, and say that so long as every subclass of ordered implements it's own implementation or proceeds we'll be OK.

So we press ahead, and make a subclass or `Ordered`.

```swift
class Number: Ordered  { 
   var value: Double = 0
   override func precedes(other: Ordered) -> Bool {
      return value < other.value
   }
}
```

Expect this doens't work. `other` has no variable for value. It's just some arbitrary object. It could be a `Label` with a `text` property. So now we need to downcast just to get to the right type.

```swift
class Label : Ordered { var text: String = "" ... }

class Number: Ordered  { 
   var value: Double = 0
   override func precedes(other: Ordered) -> Bool {
      return value < (other as! Number).value
}
```

But hold on. What if that `other` value is of type `Label`. Now we are going to trap.

This is a static type safety hole. Classes don't let us express this crucial type relationship between the type of `self` and the type of `other`. In fact you could use this as a code smell.

```swift
as! ASubclass => Code smell
```

Usually this means some kind of important type information was lost. And it is usually caused by classes being used for abstraction.

What we need is a better abstraction mechanism. One that
* Supports value types (and classes)
* Supports static type relationships (and dynamic dispatch)
* Non-monolithic
* Supports retroactive modeling
* Doesn't impose instance data on models
* Doesn't impose initialization burdens on models
* No ambiguity about what you need to override

## Protocols

Swift is a Protocol-Oriented Programming language. Have a saying in Swift.

   * Don't start with a class. Start with a protocol.
   
If we convert our class based implementation to a protocol based one we see the following.

1. Type safe check instead of dynamic runtime check.
   
```swift
protocol Ordered {
   func precedes(other: Ordered) -> Bool 
}
```

Since protocols don't allow us to implement any default implementations, we lose the fatal trap and instead gain a compile tie check instead of relying on the dynamic runtime check.

2. No more override.

By converting `Number` from a class to a struct

```swift
class Number: Ordered  { 
   var value: Double = 0
   override func precedes(other: Ordered) -> Bool {
      return self.value < (other as! Number).value
}
```

the protocol is playing the exact same role as the class did in the previous example. It's better. We don't have the underlying fatal error anymore. But it still isn't address the underlying problem we have of the static type safety hole. Because we still need that forced downcast.

So lets's make it a `Number` instead and drop the downcast.

```swift
class Number: Ordered  { 
   var value: Double = 0
   override func precedes(other: Number) -> Bool {
      return self.value < (other as! Number).value
}
```

Now Swift is going to complain that the signatures don't match up. `Number` isn't and `Ordered`.

To fix this, we need to replace `Ordered` in the protocol method signature with `Self`.

```swift
protocol Ordered {
   func precedes(other: Self) -> Bool 
}
```

Note the capital `S` on `Self`. This is called a "Self" requirement. So when you see `Self` in a protocol it's a placeholder for the type that is going to conform to a protcol. A model type. A Generic

So now instead of having a heterogeous array of type `[Ordered]` Swift requires us to make this a homogeneous type of the generic we just created - `T`.

```swift
// before
func binarySearch(sortedKeys: [Ordered], forkey k: Ordered) -> Int {

// after
func binarySearch<T : Ordered>(sortedKeys: [T], forkey k: T) -> Int {
```

This one says I work on any homogeneous `Ordered` array type `T`.

Now you might think that forcing the array to be homogenous is to restrictive. That we are somehow taking away functionality of forcing it unduly into a certain type. But if you think about it, the original signature was really a lie. We never handled the hetergeneous case other than by trapping. A homogeneous array is what we want.

Once you add the `Self` or generic type to the protocol, it moves the protocol into a very different world where the capabilities have a lot less overlap with classes. It stops being usable as a type. Collections become homogeneous instead of heterogeneous. Interactions between instance no longer implies an interaction between all model types. We trade dynamic polymorphism for static polymorphism and make it more optimizable for the compiler.

Later on we will see how to build a bridge between these two worlds.

### The beauty of this - adding functionality to types is easy

The beauty of working this way is it becomes very easy to create new type instances that conform to protocols, and use them in different instances. Like tests.

```swift
extension Renderer {
   func circleAt(center: CGPoint, radius: CGFloat) { ... }
}

extension TestRenderer {
   func circleAt(center: CGPoint, radius: CGFloat) { ... }
}
```

## Examples

```swift
@objc protocol PayBillUserActions {    
    @objc optional func performCancelPayBillAction(sender: Any?)
    @objc optional func performConfirmPayBillAction(sender: Any?)
}

private extension Selector {
    static let performCancelPayBillAction = #selector(PayBillUserActions.performCancelPayBillAction(sender:))
    static let performConfirmPayBillAction = #selector(PayBillUserActions.performConfirmPayBillAction(sender:))
}

extension PayBillViewController: PayBillUserActions {
    
    func addButtonTargets() {
        cancelButton.addTarget(nil, action: .performCancelPayBillAction, for: .primaryActionTriggered)
        confirmButton.addTarget(nil, action: .performConfirmPayBillAction, for: .primaryActionTriggered)
    }

    func performCancelPayBillAction(sender: Any?) {
        ...
    }
    
    func performConfirmPayBillAction(sender: Any?) {
        ...
    }
}
```

### Links that help

* [Protocol Oriented Programming - WWDC 2015](https://developer.apple.com/videos/play/wwdc2015/408/)
* [Type Values in Swift - WWDC 2015](https://developer.apple.com/videos/play/wwdc2015/414/)
* [Protocol and Value Oriented Programming in UIKit Apps - WWDC 2016](https://developer.apple.com/videos/play/wwdc2016/419/?time=340)
