# Singletons

Swift uses singletons when it wants only one instance of a class to exist.

```swift
let defaults = UserDefaults.standard
let sharedURLSession = URLSession.shared
```

A Singleton is Swift is implemented with the static key word

```swift
class Singleton {
    static let sharedInstance = Singleton()
}
```

But you can create also create thsm like this with a private constructor

```swift
class NetworkManager {

    static let shared = NetworkManager(baseURL: API.baseURL)

    let baseURL: URL

    private init(baseURL: URL) {
        self.baseURL = baseURL
    }

}
```

Or more simply with a closure like this

```swift
class Singleton {
    static let sharedInstance: Singleton = {
        let instance = Singleton()
        // setup code
        return instance
    }()
}
```

The advantage of the private constructor is no one can accidentally create a non-shared instance.

### Links that help

* [Apple Docs](https://developer.apple.com/documentation/swift/cocoa_design_patterns/managing_a_shared_resource_using_a_singleton)
* [Example](https://cocoacasts.com/what-is-a-singleton-and-how-to-create-one-in-swift)



