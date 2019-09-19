# Assert, Precondition and Fatal Error in Swift

Sometimes it is better to crash than leave your app in an inconsistent state. Here are the five ways to fail (other than `exit()` and `abort()`).

* assert()
* assertionFailure()
* precondition()
* preconditionFailure()
* fatalError()

### assert()

Use asserts for programmer errors.

```swift
func printAge(_ age: Int) {
    assert(age >= 0, "Age can't be a negative value")
    
    print("Age is: ", age)
}
```

### assertionFailure()

```swift
func printAge(_ age: Int) {
    guard age >= 0 else {
        assertionFailure("Age can't be a negative value")
        return
    }
    print("Age is: ", age)
}
```

### precondition()

A harder form of assert, precondition will stop your program in debug and release builds.

```swift
func printAge(_ age: Int) {
    precondition(age >= 0, "Age can't be a negative value")
    
    print("Age is: ", age)
}

printAge(-1) // prints: precondition failed: Age can't be a negative value
```

### preconditionFailure()

Same as above.

```swift
func printAge(_ age: Int) {
    guard age >= 0 else {
        preconditionFailure("Age can't be a negative value")
    }
    print("Age is: ", age)
}

printAge(-1) // prints: fatal error: Age can't be a negative value
```

If you look a bit closely at the method signature for this function, you’ll see that it has a return type:

```swift
public func preconditionFailure(... file: StaticString = #file, line: UInt = #line) -> Never
```

Return type ‘Never’ indicates that this function will never return. It will stop the execution of the app. That’s why Xcode won’t complain about the guard statement falling through because of the missing return statement.

### fatalError()

fatalError(), like assertionFailure() and preconditionFailure(), takes a string as an argument that will be printed in the console before the app terminates. It works for all optimisation levels in all build configurations. You use it just like the other two:

```swift
func printAge(_ age: Int) {
    guard age >= 0 else {
        fatalError("Age can't be a negative value")
    }
    print("Age is: ", age)
}

printAge(-1) // prints: fatal error: Age can't be a negative value
```

And just like the preconditionFailure() it has a return type of ‘Never’.

# Representing Errors

Errors in Swift are modeled using a type that conforms to the Error protocol. It is an empty protocol so there are no properties or methods to implement. It’s a marker interface that indicates that a type can be used for error handling.

Swift enums are good for modeling errors. 

```swift
enum EnrollmentError: Error {
    case inactiveStudent
    case doesNotMeetMinLevel(minLevel: Int)
    case courseFull
}
```

You throw them like this

```swift
func enroll(_ student: Student) throws {
    guard student.active else {
        throw EnrollmentError.inactiveStudent
    }
    guard student.level >= minLevel else {
        throw EnrollmentError.doesNotMeetMinLevel(minLevel: minLevel)
    }
    guard students.count < capacity else {
        throw EnrollmentError.courseFull
    }
    students.append(student)
}
```

And you catch them like this

```swift
class EnrollmentHandler {
    func enroll(_ student: Student, inCourse course: Course) {
        do {
            try course.enroll(student)
            print("Successfully enrolled \(student.name) in \"\(course.name)\"")
        } catch EnrollmentError.inactiveStudent {
            print("\(student.name) is not an active student")
        } catch let EnrollmentError.doesNotMeetMinLevel(minLevel) {
            print("Could not enroll \(student.name). Must at least be at level \(minLevel)")
        } catch EnrollmentError.courseFull {
            print("Could not enroll \(student.name). Course is full")
        } catch {
            print("Unknown error")
        }
}
```

NOTE
> Error handling in Swift resembles exception handling in other languages, with the use of the try, catch and throw keywords. Unlike exception handling in many languages—including Objective-C—error handling in Swift does not involve unwinding the call stack, a process that can be computationally expensive. As such, the performance characteristics of a throwstatement are comparable to those of a return statement.

# Various ways to handle errors in Swift

## External / Recoverable Errors 
These errors result from networks being down, users entering invalid data. These are are things we can recover from and give a good UI experience when handling.

* **Return nil or an error enum case**. The simplest form of error handling is to simply return nil (or an .error case if you’re using a Result enum as your return type) from a function that encountered an error. While this can be really useful in many situations, over-using it for all error handling can quickly lead to APIs that are cumbersome to use, and also risks hiding faulty logic.
* **Throwing an error**, which requires the caller to handle potential errors using the do, try, catch pattern. Alternatively, errors can be ignored using try? at the call site.

## Internal / Non-recoverable Errors
These are programmer errors. Errors in logic, carelessness, or things we just didn’t think about and catch when coding up the program. For these there is no recovery. Our program is basically in an inconsistent state. And things have to stop. All we have to decide is how hard we want to slam on the breaks.


* **Using assert() and assertionFailure()** to verify that a certain condition is true. Per default, this causes a fatal error in debug builds, while being ignored in release builds. It’s therefor not guaranteed that execution will stop if an assert is triggered, so it’s kind of like a severe runtime warning.
* **Using precondition() and preconditionFailure()** instead of asserts. The key difference is that these are always* evaluated, even in release builds. That means that you have a guarantee that execution will never continue if the condition isn’t met.
* **Calling fatalError()** - which you have probably seen in Xcode-generated implementations of init(coder:) when subclassing an NSCoding-conforming system class, such as UIViewController. Calling this directly kills your process.
* **Calling exit()**, which exists your process with a code. This is very useful in command line tools and scripts, when you might want to exit out of the global scope (for example in main.swift).

*Unless you are compiling using the `-Ounchecked` optimization mode.

What's the difference between a precondition() and a fatalError()? It's subtle, but fatal is executed under all conditions of release, while precondition will not be included if you deploy your app in a special unchecked Swift optimization. See [here](https://blog.krzyzanowskim.com/2015/03/09/swift-asserts-the-missing-manual/) for a deeper explaination.

|         Error mode                   | debug           | release  |
| -------------------------- |:----------:| -----:|
| Optimization mode          | -Onone        | -O |
| assert()                   | YES        | NO | 
| assertFailure()            | YES        | NO | 
| precondition()             | YES | YES | 
| preconditionFailure()      | YES | YES | 
| fatalError()*              | YES | YES | 

YES - is for termination, NO - no termination.

### Examples of Recoverable Errors
When dealing with an asynchronous tasks, returning nil or an error enum case is probably the best choice

```swift
class DataLoader {
    enum Result {
        case success(Data)
        case failure(Error?)
    }

    func loadData(from url: URL,
                  completionHandler: @escaping (Result) -> Void) {
        let task = urlSession.dataTask(with: url) { data, _, error in
            guard let data = data else {
                completionHandler(.failure(error))
                return
            }

            completionHandler(.success(data))
        }

        task.resume()
    }
}
```

For synchronous APIs, throwing is a great option — as it “forces” our API users to handle the error in an appropriate way:

```swift
class StringFormatter {
    enum Error: Swift.Error {
        case emptyString
    }

    func format(_ string: String) throws -> String {
        guard !string.isEmpty else {
            throw Error.emptyString
        }

        return string.replacingOccurences(of: "\n", with: " ")
    }
}
```

### Examples of Non-recoverable
```swift
guard let image = UIImage(named: selectedImageName) else {
    preconditionFailure("Missing \(selectedImageName)")
}

guard let account = session.selectedAccount else { 
    fatalError("attempt to pay bill w/o an account") 
}
```

## Try vs try? Vs try!
There are two other flavours of try that don’t need to appear inside the do-catch statement.

### Converting errors to optionals with try?

This is handy when you want to know that an error was thrown but you don’t particular care what the error is.
```swift
enum TestError: Error {
    case someError
}

func canThrowButDoesNot() throws -> String {
    return "My string"
}

func canAndDoesThrow() throws -> String {
    throw TestError.someError
}

print((try? canThrowButDoesNot()) ?? "nil")     // My string
print((try? canAndDoesThrow()) ?? "nil")        // nil
```

try? converts and error into an optional. If an error is thrown inside the try? expression, the expression evaluate to nil. If there is no error, the expression evaluates to an optional wrapping the return value.

### Asserting that errors will not occur with try!

The try! keyword can be used to assert that an error will not be thrown. If there is no error, execution continues as normal. If there is an error however - BOOM the application will crash.

```swift
// Using try! is dangerous. Will cause a crash if error is thrown
print(try! canThrowButDoesNot())    // My string
print(try! canAndDoesThrow())       // Crash!!!
```

Using this in production code is generally not recommended.

### Clean up with defer

A defer statement can be used to ensure that certain actions are performed before the current scope is executed.

```swift
func throwerWithDefer(shouldThrow: Bool) throws {
    defer {
        print("First defer statement executed")
    }
    defer {
        print("Second defer statement executed")
    }
    print("Prior to throw")
    if shouldThrow {
        throw TestError.someError
    }
    print("After throw")
    defer {
        print("Third defer statement executed")
    }
}
```

Note that defer statements execute in reverse order.

```swift
try? throwerWithDefer(shouldThrow: false)
// Prior to throw
// After throw
// Third defer statement executed
// Second defer statement executed
// First defer statement executed

try? throwerWithDefer(shouldThrow: true)
// Prior to throw
// Second defer statement executed
// First defer statement executed
```

## How to throw an error

```swift
public struct ActivationManager: ActivationManagerProtocol {
    let session: MyAccountSession
    let account: Account

    init(session: MyAccountSession) throws {
        self.session = session

        guard let possibleAccount = session.selectedAccount else {
            throw ActivationError.initialization(message: "Account required")
        }

        self.account = possibleAccount
    }
```


### Links that help
* https://agostini.tech/2017/10/01/assert-precondition-and-fatal-error-in-swift/
* https://khawerkhaliq.com/blog/swift-error-handling/
* https://www.swiftbysundell.com/posts/picking-the-right-way-of-failing-in-swift
* https://blog.krzyzanowskim.com/2015/03/09/swift-asserts-the-missing-manual/
* https://developer.apple.com/documentation/swift/1541112-assert
* https://developer.apple.com/documentation/swift/1539616-assertionfailure
* https://developer.apple.com/documentation/swift/1540960-precondition
* https://developer.apple.com/documentation/swift/1539374-preconditionfailure
* https://developer.apple.com/documentation/swift/1538698-fatalerror


