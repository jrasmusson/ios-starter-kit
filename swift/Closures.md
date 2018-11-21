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

A trailing closure is a closure expression that is passed in as the final argument of a function. It's written after the call's parenthese, even though it is still an argument. When you use the trailing closure syntax, you don't write the argument label for the closure as part of the function call.

```swift
func someFunctionThatTakesAClosure(closure: () -> Void) {
    // function body goes here
}

// Here's how you call this function without using a trailing closure:

someFunctionThatTakesAClosure(closure: {
    // closure's body goes here
})

// Here's how you call this function with a trailing closure instead:

someFunctionThatTakesAClosure() {
    // trailing closure's body goes here
}
```

The string sorted closure in the previous section can also be written this way because the closure is the last argument passed in. And we can even simply if further by removing the parentheses.

```swift
reversedNames = names.sorted(by: { $0 > $1 } ) // closure as argument
reversedNames = names.sorted() { $0 > $1 } // trailing closure
reversedNames = names.sorted { $0 > $1 } // trailing closure no parentheses
```

## Capturing Values

A closure can _capture_ constants and variables from the surrounding context in which it is defined. The closure can then refer to and modify the values of those constants from within it's own body, even if the scope originally defining them no longer exists.

For example here is a function that makes incrementing closures.

```swift
func makeIncrementer(forIncrement amount: Int) -> () -> Int {
    var runningTotal = 0
    func incrementer() -> Int {
        runningTotal += amount
        return runningTotal
    }
    return incrementer
}
```

The return type of `makeIncrementer` is `() -> Int`. That means that it returns a _function_ rather than a simple value. The function has no parameters, and returns an `Int` everytime it is called.

Notice however that `makeIncrementer(forIncrement:)` has an argument called `amount`. The closure has access to this variable because it is nested within the function.

It does this by capturing a _reference_ to `runningTotal` and `amount` from the surrounding function. This is what we call capturing values.

Here is the `makeIncrementer` in action

```swift
let incrementByTen = makeIncrementer(forIncrement: 10)
incrementByTen()
incrementByTen()
incrementByTen()
// returns a value of 39
```

And by calling it three times it would return a value of 30.

## Closing Are Reference Types

Those closures we just defined are also reference types. That means you could recreate another variable, reference it, and increment it again and still get the original value.

```swift
let alsoIncrementByTen = incrementByTen
alsoIncrementByTen()
// returns a value of 40
```

## Escaping Closures

A closure is said to escape a function when the closure is passed as an argument to the function, but is called after the function returns. Escaping closures are used in asynchronous completion hanlders.

For example, here is an array of `completionHandlers` and an `@escaping` closure that will be executed _after_ the method in which is is called.

```swift
var completionHandlers: [() -> Void] = []
func someFunctionWithEscapingClosure(completionHandler: @escaping () -> Void) {
    completionHandlers.append(completionHandler)
}
```

Here on the other hand is a non-escaping closure that will get called instantly as soon as the method is invoked.

```swift
func someFunctionWithNonescapingClosure(closure: () -> Void) {
    closure()
}
```

To see this in action, what what happens when both are invoked within a given method.

```swift
class SomeClass {
    var x = 10
    func doSomething() {
        someFunctionWithEscapingClosure { self.x = 100 }
        someFunctionWithNonescapingClosure { x = 200 }
    }
}

let instance = SomeClass()
instance.doSomething()
print(instance.x)
// Prints "200"

completionHandlers.first?()
print(instance.x)
// Prints "100"
```

The first time `instance.x` is printed, 200 comes out because that was the closure that was non-escaping meaning it gets executed instantly.

But when we explicitly execute the `escaping` closure, the one we have reference to in our array, it resets `x` after the method has already executed. It can do this because it was marked `escaping`. Meaning it can execute after the fact. Which is why you will see this style of closure used lots in asynchronous programming.

## Autoclosures

An autoclosure is a closure that is automatically created to wrap an expression that's being passed as an argument to a function. It doesn't take any arguments, and when it's called, it returns that value of the expression that's wrapped inside it. 

This syntactic convenience lets you omit braces around a function's parameter by writing a normal expression instaead of an explicit closure.

An autoclosure lets you delay evaluation, because the code inside isn't run until you call the closure. Delaying execution is useful for code that has side effects or is computationally expensive, because it lets you decide when to call it.

```swift
var customersInLine = ["Chris", "Alex", "Ewa", "Barry", "Daniella"]
print(customersInLine.count)
// Prints "5"

let customerProvider = { customersInLine.remove(at: 0) }
print(customersInLine.count)
// Prints "5"

print("Now serving \(customerProvider())!")
// Prints "Now serving Chris!"
print(customersInLine.count)
// Prints "4"
```

For example here we have an array which prints out 5 when initially created.
If we define a closure now called `customerProvider` that removes the first element and returns a string, we can still print 5 because we haven't yet executed the closure.
If we execute it after, we will see the the count is decremented to 4.

Here is a better way to see he difference. Let's pass in the same argument to two functions. One autoclosing, and the other one not.

```swift
// customersInLine is ["Alex", "Ewa", "Barry", "Daniella"]
func serve(customer customerProvider: () -> String) {
    print("Now serving \(customerProvider())!")
}
serve(customer: { customersInLine.remove(at: 0) } )
// Prints "Now serving Alex!"
```

In the non-autoclosing example, look at how we call the function.

```swift
serve(customer: { customersInLine.remove(at: 0) } )
```

We need the parenthese, because it is not an autoclosing function.

But look what happens if we make it autoclosing.

```
// customersInLine is ["Ewa", "Barry", "Daniella"]
func serve(customer customerProvider: @autoclosure () -> String) {
    print("Now serving \(customerProvider())!")
}
serve(customer: customersInLine.remove(at: 0))
// Prints "Now serving Ewa!"
```

Now when we called it, we don't need the parentheses. We can just inline the closure and it will automatically wrap it for us and return the value when called.

> Note: Overusing autoclosure can make your code hard to understand. The context and function name should make it clear that evaluation is being defereed.


Links that help
* https://docs.swift.org/swift-book/LanguageGuide/Closures.html
* https://medium.com/@abhimuralidharan/functional-swift-all-about-closures-310bc8af31dd
