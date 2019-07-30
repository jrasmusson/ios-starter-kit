# Result

An enum representing success or failure in an operation. If success return the success. If failure return the failure.

```swift
/// A value that represents either a success or a failure, including an
/// associated value in each case.
public enum Result<Success, Failure> where Failure : Error {

    /// A success, storing a `Success` value.
    case success(Success)

    /// A failure, storing a `Failure` value.
    case failure(Failure)
```

Example

```swift
func refreshOrders(completion: @escaping ((Result<[OrderItem], Error>) -> Void)) {

	completion(Result.failure(ActivationError.coreData))

    self.selectedAccount?.orderItems = NSSet(array: collection)
    completion(Result.success(collection))
                
}
```
