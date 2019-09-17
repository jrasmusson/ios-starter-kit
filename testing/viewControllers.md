# How to test ViewControllers


```swift
import XCTest
import UnitTests

class Tests: XCTestCase {

    var viewController: ViewController!

    override func setUp() {
        viewController = viewController()
    }

    func testHiddenButton() throws {
        _ = self.viewController.view // To call viewDidLoad
        
        statusViewController.beginAppearanceTransition(true, animated: false) // viewWillAppear
        statusViewController.endAppearanceTransition() // viewWillDisappear
        ...
    }
}
```

### Links that help

* [Testing Tips & Tricks - WWDC 2018](https://developer.apple.com/videos/play/wwdc2018/417/?time=761)

