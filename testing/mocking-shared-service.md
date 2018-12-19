# How to mock a shared service

Say you have a singleton shared service

```swift
import Alamofire

class OrderDetailsService {

    static let sharedInstance = OrderDetailsService()

    func fetchStatus(completion: @escaping (String?, Error?) -> Void ) {
        Alamofire.request("https://foo.com", method: .get, encoding: JSONEncoding.default).responseJSON { response in
            completion("active", nil)
        }
    }
}
```

And you want to write a test for that in your `UIViewController`.

```swift
import UIKit

class ViewController: UIViewController {

    var isActive = false

    override func viewDidLoad() {
        super.viewDidLoad()

        OrderDetailsService.sharedInstance.fetchStatus { (status, error) in

            guard let status = status else {
                return
            }

            if status == "activate" {
                self.isActive = true
            } else {
                self.isActive = false
            }
        }
    }
}
```

Here is how you do it.

### Step 1: Dependency inject the object you want to stub into the ViewController

```swift
import UIKit

class ViewController: UIViewController {

    var isActive = false
    let orderDetailsService: OrderDetailsService

    public init(orderDetailsService: OrderDetailsService = OrderDetailsService.sharedInstance) {
        self.orderDetailsService = orderDetailsService
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        orderDetailsService.fetchStatus { (status, error) in

            guard let status = status else {
                return
            }

            if status == "Active" {
                self.isActive = true
            } else {
                self.isActive = false
            }
        }
    }
}
```

### Step 2: Override the class with a mock or a stub

```swift
class OrderDetailsServiceStub: OrderDetailsService {

    var status = "Active"
    var expectation: XCTestExpectation?

    override func fetchStatus(completion: @escaping (String?, Error?) -> Void) {
        completion(status, nil)
        expectation?.fulfill()
    }
}
```

### Step 3: Use that stub in your unit test

```swift
import XCTest
@testable import TestingSharedService

class TestingSharedServiceTests: XCTestCase {

    var viewController: ViewController!

    override func setUp() {
    }

    func testExample() {
        let expectation = self.expectation(description: "Test active")
        let stub = OrderDetailsServiceStub()
        stub.expectation = expectation

        viewController = ViewController(orderDetailsService: stub)
        viewController.loadViewIfNeeded()

        XCTAssert(viewController.isActive)

        self.waitForExpectations(timeout: 10)
    }

}

class OrderDetailsServiceStub: OrderDetailsService {

    var status = "Active"
    var expectation: XCTestExpectation?

    override func fetchStatus(completion: @escaping (String?, Error?) -> Void) {
        completion(status, nil)
        expectation?.fulfill()
    }
}
```

### Links that help

* [Big Nerd Ranch Mocking](https://www.bignerdranch.com/blog/mocking-with-protocols-in-swift/)
* [Testing Tips & Tricks - WWDC 2018](https://developer.apple.com/videos/play/wwdc2018/417/?time=761)

