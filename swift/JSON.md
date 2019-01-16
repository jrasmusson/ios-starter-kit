# JSON

## The Basics
Define a `struct`. Make it `Decodable`.

```swift
import UIKit

struct User: Codable {
    let firstName: String
    let lastName: String
    let age: Int
    let job: JobType

    enum CodingKeys : String, CodingKey {
        case firstName
        case lastName = "last_name"
        case age
        case job
    }
}

enum JobType : String, Codable {
    case developer
    case qa
    case manager
}

let jsonString = """
{
    "firstName": "Joe",
    "last_name": "Smith",
    "age": 34,
    "job": "developer",
}
"""
let jsonData = jsonString.data(using: .utf8)!
let decoder = JSONDecoder()
let user = try! decoder.decode(User.self, from: jsonData)
```

### Links that help

* [Guide](https://benscheirman.com/2017/06/swift-json/)

