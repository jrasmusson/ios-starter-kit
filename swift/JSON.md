# JSON

## Example


```swift

/subscriptionInternet

{
    "activeHardware": [
        {
            "type": "xxx",
            "model": "xxx"
        }
    ]
}
```

First create a struct for the highest level of the thing you are calling. In this case something to hold an array of hardwares.

```swift
public struct SubscriptionInternet: Codable {
    public let activeHardwares: [ActiveHardware?]
}
```

Then parse the thing inside. Make `Optional` if there is a chance the thing you are calling may not be there.

```swift
public struct ActiveHardware: Codable {
    public let type: String?
}
```

Then test like this.

```swift
class ActiveHardWareJSONSpec: QuickSpec {

    override func spec() {

        describe("when parsing") {

            context("simple case") {

                it("should work") {
                    let json = """
                     {
                        "type": "xxx",
                        "model": "xxx"
                     }
                    """
                    let jsonData = json.data(using: .utf8)!
                    let decoder = JSONDecoder()
                    let result = try! decoder.decode(ActiveHarware.self, from: jsonData)

                    XCTAssertEqual("xxx", result.type)
                }
            }
        }
    }
}

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

