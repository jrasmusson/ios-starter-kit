# Protocol Based Inheritance

There are two ways you can do inheritance in swift.

### Class based inheritance

```swift
class ActivationService {

    func handle<T: Codable>(response: DataResponse<Data>, completion: @escaping (T?, Error?) -> ()) {
        switch response.result {
        case .success:
	        completion(result, error)
        case .failure(let error):
            completion(nil, error)
        }
    }
    
}
```

### Protocol based inheritance

```swift
protocol ActivationService {

}

extension ActivationService {

    func handle<T: Codable>(response: DataResponse<Data>, completion: @escaping (T?, Error?) -> ()) {
        switch response.result {
        case .success:
	        completion(result, error)
        case .failure(let error):
            completion(nil, error)
        }
    }

}
```

The advantage of protocal based inheritance non-class types (like structs) are the following

* you don't lose your single inheritance - its still there if you need it
* you can compose objects through protocols as opposed to inheriting functionality
* you can be more nuanced in how you apply that new functionality

The second point here is the big one. Instead of using inheritance as the means of sharing funcationality you compose it.

For example with single inheritance based languages you can't go

```swift
class SomeClass: Inherit1, Interit2, Inherit3 {
    // Boom! Only single inhertiance allowed
}
```

But with protocol based inheritance you can.

```swift
class SomeClass: Protocol1, Protocol2 {

protocol Protocol1 {

}

extension Protocol1 {
	func one() { // impl }
}

protocol Protocol2 {

}

extension Protocol2 {
	func two() { // impl }
}
```

## An example

Say we have a ViewController that implements a delegate protocol, and there is a common method `recordSupportArticleTapped` that is shared amongst several implementations.

```swift
extension JoinWifiViewController: SupportArticleViewDelegate {

    func didSelectArticle(withURL url: URL, userInfo: Any) {
        present(SFSafariViewController(url: url), animated: true)

        guard let analyticsEvent = userInfo as? Analytics.Actions.Activation else { return }
        recordSupportArticleTapped(forURL: url, analyticsEvent: analyticsEvent)
    }

    // Want to extract this method for reuse somewhere
    func recordSupportArticleTapped(forURL url: URL, analyticsEvent: Analytics.Actions.Activation) {

        let analyticsData: [String: AnyHashable] = [
            "supportArticleUrl": url.absoluteString
        ]

        analytics.trackEvent(withTitle: analyticsEvent.rawValue, context: analyticsData)
    }
```

### Extract to existing protocol

One way we could do it is to extract this could and put it with the original protocal we defined like this

```swift
protocol SupportArticleViewDelegate: AnyObject {
    func didSelectArticle(withURL url: URL, userInfo: Any)
}

extension SupportArticleViewDelegate {

    func recordSupportArticleTapped(forURL url: URL, analyticsEvent: Analytics.Actions.Activation) {

        let analyticsData: [String: AnyHashable] = [
            "supportArticleUrl": url.absoluteString
        ]

        Analytics.sharedInstance.trackEvent(withTitle: analyticsEvent.rawValue, context: analyticsData)
    }
}
```

Advantage here is now everyone implementing this protocol gets this implementation, with no class based inheritiance.

But what if this functionality doens't really belong here. And say it belongs somewhere else. In that case we can create a new protocol and stick it there.

### Extract into a new protocol

```swift
protocol SupportArticleViewDelegate: AnyObject {
    func didSelectArticle(withURL url: URL, userInfo: Any)
}

protocol SupportArticleAnalytics {

}

extension SupportArticleAnalytics {
    func recordSupportArticleTapped(forURL url: URL, analyticsEvent: Analytics.Actions.Activation) {

        let analyticsData: [String: AnyHashable] = [
            "supportArticleUrl": url.absoluteString
        ]

        Analytics.sharedInstance.trackEvent(withTitle: analyticsEvent.rawValue, context: analyticsData)
    }
}
```

The idea here is separation of concerns. Now we have two distinctly different pieces of functionality, and our users are free to implement which ever one they like. Like this.

```swift
extension JoinWifiViewController: SupportArticleViewDelegate, SupportArticleAnalytics {

    func didSelectArticle(withURL url: URL, userInfo: Any) {
        present(SFSafariViewController(url: url), animated: true)

        guard let analyticsEvent = userInfo as? Analytics.Actions.Activation else { return }
        recordSupportArticleTapped(forURL: url, analyticsEvent: analyticsEvent)
    }
}
```

### Links that help

* [Protocol Oriented Programming - WWDC 2015](https://developer.apple.com/videos/play/wwdc2015/408/)
* [Type Values in Swift - WWDC 2015](https://developer.apple.com/videos/play/wwdc2015/414/)
* [Protocol and Value Oriented Programming in UIKit Apps - WWDC 2016](https://developer.apple.com/videos/play/wwdc2016/419/?time=340)
* [Unit testing with protocols](https://riptutorial.com/swift/example/8271/leveraging-protocol-oriented-programming-for-unit-testing)
