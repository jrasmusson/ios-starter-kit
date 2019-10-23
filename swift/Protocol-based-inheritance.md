# Protocol Based Inheritance

There are two ways you can do inheritance in swift.

### Class based inheritance

Swift doesn't have the concept of abstract class. But we can do straight up inheritance like this.

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

The Swift was of protocol inheritance however doesn't use classes. Instead you define a protocol, and then give desired shared functionality via it's extension.

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

## One draw back - Composition to the rescue

One thing protocol based inheritance doesn't do very well is properites. You can't share properties via inheritance through protocols. For example in our above example what ever we wanted to share a common data source that gave us authorization tokens for logging in.

We can't do that with protocols. So here we can either go back to traditional class based inheritance, or use composition instead.

Create the object you want to contain the data and functionality you want to share.

```swift
public class NetworkHandler {

    public static let sharedInstance = NetworkHandler()

    public var dataSource: NetworkingDataSource?

    func handle<T: Codable>(response: DataResponse<Data>, completion: @escaping (T?, Error?) -> Void) {
        switch response.result {
        case .success:

            guard let jsonData = response.result.value else {
                completion(nil, NetworkHandlerError.noData)
                return
            }

            let decoder = JSONDecoder()
            do {
                let result = try decoder.decode(T.self, from: jsonData)
                completion(result, nil)
            } catch {
                completion(nil, NetworkHandlerError.parsingJSON)
            }

        case .failure(let error):
            completion(nil, error)
        }
    }

}
```

Set the data externally that needs to be set.

```swift
// set accessToken on classes needing network
NetworkHandler.sharedInstance.dataSource = session
```

Then use compose your new functionality as an element in the class where required.

```swift
public class InternetSubscriptionService {

    // composition!
    public var networkHandler = NetworkHandler.sharedInstance

    public func fetchInternetSubscription(completion: @escaping (InternetSubscription?, Error?) -> Void ) {

        guard let accessToken = networkHandler.dataSource?.accessToken else {
            completion(nil, NetworkHandlerError.noAccessToken)
            return
        }

        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(accessToken)"
        ]

	let request = Alamofire.request(url, method: .get, encoding: JSONEncoding.default, headers: headers)

        request.responseData { response in
            self.networkHandler.handle(response: response, completion: completion)
        }
    }

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



### Another example of how to add functionality to a class without changing it?

Ruby calls these mixins. 
Eliminate the need for multiple inheritance.

For example say you have some common code for creating a ContextMenu, and you want to share it among multiple ViewControllers.

Instead of creating a parent viewController, and adding that functionality through inheritance, you can create a protocol and add the functionality from there.

```swift
import UIKit

protocol ContextMenuDemo {
    static var title: String { get }
}

extension ContextMenuDemo {
    func makeDefaultDemoMenu() -> UIMenu {

        // Create a UIAction for sharing
        let share = UIAction(title: "Share", image: UIImage(systemName: "square.and.arrow.up")) { action in
            // Show system share sheet
        }

        // Create an action for renaming
        let rename = UIAction(title: "Rename", image: UIImage(systemName: "square.and.pencil")) { action in
            // Perform renaming
        }

        // Here we specify the "destructive" attribute to show that it’s destructive in nature
        let delete = UIAction(title: "Delete", image: UIImage(systemName: "trash"), attributes: .destructive) { action in
            // Perform delete
        }

        // Create and return a UIMenu with all of the actions as children
        return UIMenu(title: "", children: [share, rename, delete])
    }
}
```

You can now add this functionality to any ViewController you like, simply by adding the protocol.

```swift
class VCPreviewSingleViewController: UIViewController, ContextMenuDemo {


}
```

And then using it like this

```swift
extension VCPreviewSingleViewController: UIContextMenuInteractionDelegate {

    func contextMenuInteraction(_ interaction: UIContextMenuInteraction, configurationForMenuAtLocation location: CGPoint) -> UIContextMenuConfiguration? {
        return UIContextMenuConfiguration(identifier: nil, previewProvider: MountainsPreviewViewController.init) { suggestedActions in
            return self.makeDefaultDemoMenu() // < HERE
        }
    }

}
```

### Links that help

* [Protocol Oriented Programming - WWDC 2015](https://developer.apple.com/videos/play/wwdc2015/408/)
* [Type Values in Swift - WWDC 2015](https://developer.apple.com/videos/play/wwdc2015/414/)
* [Protocol and Value Oriented Programming in UIKit Apps - WWDC 2016](https://developer.apple.com/videos/play/wwdc2016/419/?time=340)
* [Unit testing with protocols](https://riptutorial.com/swift/example/8271/leveraging-protocol-oriented-programming-for-unit-testing)
