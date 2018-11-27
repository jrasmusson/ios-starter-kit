# Automatic Reference Counting

## How ARC works

Swift uses _Automatic Reference Counting_ to keep track of how many instances of a class have been created.

For example say we have a class `Person`.

```swift
class Person {
    let name: String
    init(name: String) {
        self.name = name
    }
}
```

When we create three Optional references to `Person` these are initially all `nil`.

```swift
var reference1: Person?
var reference2: Person?
var reference3: Person?
```

It's not until we actually instantiate an instance of person that ARC kicks in, tracks this instance, and ensures `Person` is kept in memory and not deallocated.

```swift
reference1 = Person(name: "John Appleseed")
```

If we assign the same `Person` instance to two more variables, two more strong references to that instance are created:

```swift
reference2 = reference1
reference3 = reference1
```

And we now have _three_ strong references to this single `Person` instance.

If we break two of these strong references (including the original), a single strong reference remains, and the `Person` instance is not deallocated:

```swift
reference1 = nil
reference2 = nil
```

Until we break the final one

```swift
reference3 = nil
```

## Strong Reference Cycles Between Class Instances

ARC tracks the number of references to instances of objects you create and then deallocates them when no longer needed.

It is possible however to write code such that a class _never_ gets to the point where it has zero strong references. This can happen if two classes hold strong references to each other, such that each instances keep the other alive. This is known as a _strong reference_ cycle and this is something we want to avoid at all costs.

For example, consider this `Person` object with holds a reference to an Optional `Apartment` and an `Apartment` which in turn holds a strong reference to the `Person`.

```swift
class Person {
    let name: String
    init(name: String) { self.name = name }
    var apartment: Apartment?
    deinit { print("\(name) is being deinitialized") }
}

class Apartment {
    let unit: String
    init(unit: String) { self.unit = unit }
    var tenant: Person?
    deinit { print("Apartment \(unit) is being deinitialized") }
}
```

Both of these variables have an initial value of _nil_, by virtue of being optional.

```swift
var john: Person?
var unit4A: Apartment?
```

But as soon as we create them, and then assign them to each other, they now have strong references to each other.

```swift
john = Person(name: "John Appleseed")
unit4A = Apartment(unit: "4A")

john!.apartment = unit4A
unit4A!.tenant = john
```

![Strong](https://github.com/jrasmusson/ios-starter-kit/blob/master/swift/images/arc-strong.png)


At this point we are in trouble. Because even if we _nil_ out both variables, the underlying object instances both point to each other. That means the reference count does not drop to zero, and the instances are not deallocated by ARC.

```swift
john = nil
unit4A = nil
```

![Nil](https://github.com/jrasmusson/ios-starter-kit/blob/master/swift/images/arc-nil.png)

## How to Resolve Strong Reference Cycles Between Class Instances

Swift provides two ways to resolves these strong cycles between classes

* weak
* unowned

Both `weak` and `unowned` do not create strong holds on objects when used (i.e. they don't increment the retain count in order to prevent ARC from deallocating the referred object).

A `weak` refence allows the possibility of it to become `nil` (this happens automatically when the reference object is deallocated), therefore the type of your property must be _Optional_ - so you, as a programmer, are obliged to check it before you use it (compiler will force you to).

An `unowned` reference presumes that your reference will never become `nil` during it's lifetime. An unowned reference must be set during initialization - this means that the reference will be defined as a non-optional type that cna be used safely without checks.

From the Apple docs
> Use a weak reference whenever it is valid for that reference to become nil at some point during it's life time. Conversely, use an unowned reference when you know that the reference will never be nil once it has been set during initialization.

### Example of weak

We can break the strong dependency on `Apartment` to `Person` by making it's reference to `Person` `weak`. 

```swift
class Person {
    let name: String
    init(name: String) { self.name = name }
    var apartment: Apartment?
}

class Apartment {
    let number: Int
    init(number: Int) { self.number = number }
    weak var tenant: Person?
}
```

### Example of unowned

In this example, a `Customer` may or may not have a credit card, but a `CreditCard` **will always** be associated with a `Customer`. 


```swift
class Customer {
    let name: String
    var card: CreditCard?
    init(name: String) { self.name = name }
}

class CreditCard {
    let number: UInt64
    unowned let customer: Customer
    init(number: UInt64, customer: Customer) { self.number = number; self.customer = customer }
}
```

Practically that means `Customer` must work with an _Optional_ `CreditCard` (can be nil), but `CreditCard` gets to work with an unwrapped `Customer` (can't be nil, has to be there). By allowing one to be nil, but not the other, we break the cycle and both instances can be tracked by ARC.

### Links that help

* https://docs.swift.org/swift-book/LanguageGuide/AutomaticReferenceCounting.html
* https://stackoverflow.com/questions/24011575/what-is-the-difference-between-a-weak-reference-and-an-unowned-reference
* https://medium.com/mackmobile/avoiding-retain-cycles-in-swift-7b08d50fe3ef
