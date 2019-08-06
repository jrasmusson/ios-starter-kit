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

   // Success
   self.selectedAccount?.orderItems = NSSet(array: collection)
   completion(Result.success(collection))             

   // Error
   completion(Result.failure(ActivationError.coreData))
}
```

And then when you call you pull the payload or error from the result like this by defining lets

```swift
fetchUnreadCount1(from: "https://www.hackingwithswift.com") { result in
    switch result {
    case .success(let count):
        print("\(count) unread messages.")
    case .failure(let error):
        print(error.localizedDescription)
    }
}
```

Alternatively

```swift
session.refreshOrders(completion: { (result) in
    subject = try? result.get().first
})

do {
    let orderItems = try? result.get()
} catch error {
    print("Error fetching value: \(error)")
}
```
