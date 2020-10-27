# Unit Testing

## Playground

```swift
import Foundation
import XCTest

struct User {
    let name: String
}

class UserTests: XCTestCase {
    var user: User!
    
    override func setUp() {
        super.setUp()
        user = User(name: "Flynn")
    }
    
    func testLoggingIn() {
        XCTAssertEqual(user.name, "Flynn")
    }
}

class TestObserver: NSObject, XCTestObservation {
    func testCase(_ testCase: XCTestCase,
                  didFailWithDescription description: String,
                  inFile filePath: String?,
                  atLine lineNumber: Int) {
        assertionFailure(description, line: UInt(lineNumber))
    }
}
let testObserver = TestObserver()
XCTestObservationCenter.shared.addTestObserver(testObserver)
UserTests.defaultTestSuite.run()
```
