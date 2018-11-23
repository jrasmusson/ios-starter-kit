# Hanlde overrides


```swift
extension XCTestCase {
    func assertEqual<T: Equatable>(_ expected: T, actual: T) {
        XCTAssertEqual(expected, actual)
    }
}
```

