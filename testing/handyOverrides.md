# Misc

## ViewControllers

```swift
viewController.loadViewIfNeeded() // calls viewDidLoad
viewController.beginAppearanceTransition(true, animated: false) // calls viewWillAppear
```

```swift

@testable import Module // elevated status - module components internal and public are marked as open

extension XCTestCase {
    func assertEqual<T: Equatable>(_ expected: T, _ actual: T) {
        XCTAssertEqual(expected, actual)
    }

    func assertTrue(_ expression: @escaping @autoclosure () -> Bool) {
        XCTAssertTrue(expression())
    }
}
```

## Nimble

### eventually

```swift
expect{ view.isHidden}.toEventually(beFalse(), timeout: 1.0)
```

