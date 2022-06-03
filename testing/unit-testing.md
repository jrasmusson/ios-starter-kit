# Unit Testing

## Using protocols to make code more testable

```swift
// MARK: - Unit test specific properties and methods
extension SomeViewController {
    var dateOfBirthErrorString: String {
        return dateOfBirthComponent.errorMessage
    }
```

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

## How to test a UITableView

```swift
class Component: UIView {  
    var tableView: UITableView!
```

```swift
let minimumIndexPath = IndexPath(row: 2, section: 0)

func testShouldPopulateMinimumPay() throws {
    // When
    model = makeAdditionalValues(minimumPay: 30)
    component.model = model
    
    // Then
    let cell = component.tableView.cellForRow(at: minimumIndexPath) as! QuickPaymentCell
    XCTAssertEqual(cell.amountLabel.text, "$30.00")
}
```
