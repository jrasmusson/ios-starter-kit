# defer

With the `guard` and new `throw` statement, Swift encourages a style of early return programming over nested `if` statements. This poses a challenge however. How does one clean up initialized resources after returning from the block?

The `defer` keyword helps us here by declaring a block that will only be executed when the executions leaves the current scope.

Consider this following function that needs to do the `buffer.deallocate()` call twice.

```swift
import Darwin

func currentHostName() -> String {
    let capacity = Int(NI_MAXHOST)
    let buffer = UnsafeMutablePointer<Int8>.allocate(capacity: capacity)

    guard gethostname(buffer, capacity) == 0 else {
        buffer.deallocate()
        return "localhost"
    }

    let hostname = String(cString: buffer)
    buffer.deallocate()

    return hostname
}
```

With `defer` we can instead do declare this once, and simplify our code.

```swift
func currentHostName() -> String {
    let capacity = Int(NI_MAXHOST)
    let buffer = UnsafeMutablePointer<Int8>.allocate(capacity: capacity)
    defer { buffer.deallocate() }

    guard gethostname(buffer, capacity) == 0 else {
        return "localhost"
    }

    return String(cString: buffer)
}
```

Even throug `defer` comes immediately after `allocate`, it's execution is delayed until the end of the scope.

Use `defer` whenever an API requires calls to be balanced. For example

* `allocate()` / `deallocate()`
* `wait()` / `signal()`
* `open()` / `close()`
 
### Links that help

* [NSHipster](https://nshipster.com/guard-and-defer/)


