# Stubs

```swift
class ActivationStatusServiceErrorStub: ActivationStatusProtocol {

    var expectation: XCTestExpectation?

    func fetchActivationStatus(completion: @escaping (ActivateStatus?, Error?) -> Void ) {
        completion(nil, NetworkHandlerError.noData)
        expectation?.fulfill()
        expectation = nil
    }
}

class ActivationStatusServiceSuccessStub: ActivationStatusProtocol {

    var expectation: XCTestExpectation?

    func fetchActivationStatus(completion: @escaping (ActivateStatus?, Error?) -> Void ) {
        let activateStatus = ActivateStatus(status: ActivationResult.Success.rawValue, accountNumber: "111", serialNumber: "222")
        completion(activateStatus, nil)
        expectation?.fulfill()
        expectation = nil
    }
}
```

# Mocking

## How to mock a shared service

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

Note: You need ` self.waitForExpectations(timeout: 10)` in your test to give the unit test time to wait for the processing to occur. Else your test will fail when in fact it is really passing.

## How to create and extend with protocols

Overriding an implementation works, but sometimes it can be risky. Some SDK classes can not be overriden. And it's easy to forget which methods to override.

The way to handle this is to create a new protocol, and add it as an extension to the class you want to mock.

For example, say we want to mock or override the `CLLocationManager`.

```swift
class CurrentLocationProvider: NSObject {
    let locationManager = CLLocationManager()
    override init() {
        super.init()
        self.locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
        self.locationManager.delegate = self
} }
```

Create a new protocol and make the extend the `CLLocationManager` with it.

```swift
 
protocol LocationFetcher {
    var delegate: CLLocationManagerDelegate? { get set }
    var desiredAccuracy: CLLocationAccuracy { get set }
    func requestLocation()
}
extension CLLocationManager: LocationFetcher {}
```

Now you can use that mockable protcol in your real code and override it with a default in the initializer.

```swift
class CurrentLocationProvider: NSObject {
    var locationFetcher: LocationFetcher
    init(locationFetcher: LocationFetcher = CLLocationManager()) {
        self.locationFetcher = locationFetcher
        super.init()
        self.locationFetcher.desiredAccuracy = kCLLocationAccuracyHundredMeters
        self.locationFetcher.delegate = self
} }
```

## Trouble shooting

### API violation - multiple calls made to -[XCTestExpectation fulfill]

This occurs when you are writing tests with a lot of expecations and you get a concurrency type error. Fix by setting expectation to `nil` after fullfilling.

```swift
override func fetchActivationStatus(completion: @escaping (ActivateStatus?, Error?) -> () ) {
    completion(nil, ActivationServiceError.noData)
    expectation?.fulfill()
    expectation = nil
}
```

### Links that help

* [Big Nerd Ranch Mocking](https://www.bignerdranch.com/blog/mocking-with-protocols-in-swift/)
* [Testing Tips & Tricks - WWDC 2018](https://developer.apple.com/videos/play/wwdc2018/417/?time=761)
* [Swifter - Mini Http Webserver for mocking unit tests](https://github.com/httpswift/swifter)
