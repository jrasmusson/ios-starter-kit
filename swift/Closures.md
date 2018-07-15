# Closures

Closures are self-contained blocks of code that can be passed around and used just like any other variable or function. 

![Closure expression syntax](https://github.com/jrasmusson/ios-starter-kit/blob/master/swift/images/closure-syntax.png)


# Closure Expression Syntax

One way to think of a closure is as an inlined function. For example, to turn this reverse function into a closure

```swift
func backward(s1: String, s2: String) -> Bool {
    return s1 > s2
}
var reversedNames = names.sorted(by: backward)
```

We need only
* Remove the word `func` and `method name` (e.g. backward)
* Move the opening function bracket `{` to the begining
* And then add the word `in` to where the opening bracket `{` used to be

```swift
{ (s1: String, s2: String) -> Bool in
    return s1 > s2
}
```

And because the body is so short, we can single line inline it like this

```swift
reversedNames = names.sorted(by: { (s1: String, s2: String) -> Bool in return s1 > s2 } )
```

Now watch the various ways we can simplify this closure even further.

## Inferring Type From Context

Because the sorting closure is passed as an argument to a method, Swift can infer the types of it's parameters and the type of value it returns. Because all the types can be inferred, the return arrow (->) and the parenthese around the names of the parameters can be omitted:

```swift
reversedNames = names.sorted(by: { s1, s2 in return s1 > s2 } )
```

It is always possible to infer the paremeter types and return type when passing a closure to a function or method as an inline closure expression. As a result, you never need to write an inline closure in its fullest from when the closure is used as a function or method argument.

Nonetheless, you can still make the types explicit if you wish, and doing so is encouraged if it avoids abiguity for readers of your code.

## Implicit Returns from Single-Expression Closures

Single-expression closures can implicitly return their result and are free to omit the `return` keyword.

```swift
reversedNames = names.sorted(by: { s1, s2 in s1 > s2 } )
```

## Shorthand Argument Names

Swift automatically provides shorthanded names to inline closures ($0, $1, $2 and so on). The `in` word can also be omitted since the closure is made up entirely from it's body

```swift
reversedNames = names.sorted(by: { $0 > $1 } )
```

## Operator Methods

Because Swift's `String` type defines a string-specific operator for `>` that returns a `Bool` we can even get rid of the arguments and simply pass in the `>` operator.

```swift
reversedNames = names.sorted(by: >)
```

## Trailing Closures

Links that help
* https://docs.swift.org/swift-book/LanguageGuide/Closures.html
* https://medium.com/@abhimuralidharan/functional-swift-all-about-closures-310bc8af31dd


