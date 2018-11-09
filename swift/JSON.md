# JSON

## The Basics
Define a `struct`. Make it `Decodable`.

```swift
import UIKit

struct User: Decodable {
    let firstName: String
    let age: Int
}

let jsonString = """
{
    "firstName": "Jesus",
    "age": 34,
}
"""
let jsonData = jsonString.data(using: .utf8)!
let decoder = JSONDecoder()
let user = try! decoder.decode(User.self, from: jsonData)
```

### Links that help

* [The Basics](https://medium.com/@guerrix/parsing-json-in-swift-4-the-basics-cd8270a8ff98)

