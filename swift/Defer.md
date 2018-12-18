# defer

With the `guard` and new `throw` statement, Swift encourages a style of early return programming over nested `if` statements. This poses a challenge however. How does one clean up initialized resources after returning from the block?

The `defer` keyword helps us here by declaring a block that will only be executed when the executions leaves the current scope.

Here is an example that creates a boolean that every path in the method can set, and then only calls the actual `defer` block and the completion block when everyone exists. This has the advantage of only offering one path our of the method despite there being multiple paths (due to the `guard` clauses).

```swift
func fetchActivationStatus(completion: @escaping (Bool) -> Void ) {

        OrderDetailsService.sharedInstance.fetchOrderDetails { (orderDetails, error) in

            let success: Bool

            defer {
                completion(success)
            }

            guard error == nil else {
                success = false
                assertionFailure(String(describing: error))
                return
            }

            guard let internet = orderDetails?.internet else {
                success = false
                assertionFailure("Error unwrapping orderDetails")
                return
            }

            success = internet.isSelfActivatable
        }
    }
```

Use `defer` whenever an API requires calls to be balanced. For example

* `allocate()` / `deallocate()`
* `wait()` / `signal()`
* `open()` / `close()`
 
### Links that help

* [NSHipster](https://nshipster.com/guard-and-defer/)


