# JSON

## Example - Array

Call the struct holding the json whatever you want (i.e. History). The properties inside must match.

```swift
let json = """
{
"transactions": [
  {
    "id": 699519475,
  }
 ]
}
"""

struct History : Codable {
    let transactions: [Transaction]
}

struct Transaction: Codable {
    let id: Int
}

let data = json.data(using: .utf8)!
let decoder = JSONDecoder()
let result = try! decoder.decode(History.self, from: data)
result.transactions[0].id
```


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

