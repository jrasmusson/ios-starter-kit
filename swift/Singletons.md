# Singletons

Swift uses singletons when it wants only one instance of a class to exist.

```swift
let defaults = UserDefaults.standard
let sharedURLSession = URLSession.shared
```

You can create a Singleton in Swift like this

```swift
class NetworkManager {

    static let shared = NetworkManager(baseURL: API.baseURL)

    let baseURL: URL

    private init(baseURL: URL) {
        self.baseURL = baseURL
    }

}
```


### Links that help

* [Swift Lanaguage Guide - Basics](https://docs.swift.org/swift-book/LanguageGuide/TheBasics.html)

