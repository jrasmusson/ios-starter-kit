# Private typed class

Here is a nice way to create a private typed class or struct.

```swift
struct LoginCredential {
    
    let username: String
    let password: String
    
    static let system1 = LoginCredential(id: "user1@foo.com", password: "hello")
    static let system2 = LoginCredential(id: "user2@foo.bar", password: "hello")
}
```

