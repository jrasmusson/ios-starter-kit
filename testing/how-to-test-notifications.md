# How to test notifications

Define your `notificationCenter` as a variable and dependency inject it like this

```swift
class CurrentLocationProvider {
    	static let authChangedNotification = Notification.Name("AuthChanged")
 
	let notificationCenter: NotificationCenter

	init(notificationCenter: NotificationCenter = .default) {
	    self.notificationCenter = notificationCenter
	}

	func notifyAuthChanged() {
	    let name = CurrentLocationProvider.authChangedNotification
	    notificationCenter.post(name: name, object: self)
	}
} 
```

Then test it like this

```swift
class CurrentLocationProviderTests: XCTestCase {
    func testNotifyAuthChanged() {
        let notificationCenter = NotificationCenter()
        let poster = CurrentLocationProvider(notificationCenter: notificationCenter)
		  
	// Notification only sent to this specific center, isolating test
        let name = CurrentLocationProvider.authChangedNotification
        let expectation = XCTNSNotificationExpectation(name: name, object: poster,
                                         notificationCenter: notificationCenter)
        poster.notifyAuthChanged()
        wait(for: [expectation], timeout: 0)
    }
}
```

### Links that help

* [Testing Tips & Tricks - WWDC 2018](https://developer.apple.com/videos/play/wwdc2018/417/?time=761)

