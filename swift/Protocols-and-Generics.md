# Protocols & Generics

## How to use generics in protocols

Define your product with the generic like this.

```swift
import UIKit

protocol SupportArticleViewDelegate: AnyObject {
    func didSelectArticle<P: Any>(withEvent event: P)
}

class SupportArticleView<T: Any>: UIView {

    weak var delegate: SupportArticleViewDelegate?

    var event: T

    init(event: T) {
        self.event = event
        super.init(frame: .zero)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func fireEvent() {
        delegate?.didSelectArticle(withEvent: event)
    }
}
```

Then set yourself up as the client like this

```swift
class TestClient {

    var view: SupportArticleView<String>

    init() {
        view = SupportArticleView(event: "bigEvent")
        view.delegate = self
    }

    func fireEvent() {
        view.fireEvent()
    }
}

extension TestClient: SupportArticleViewDelegate {
    
    func didSelectArticle<T>(withEvent event: T) {
        guard let event = analyticsEvent as? String else { return }
        print("\n\n\(event)\n\n")
    }

}
```

Then use it like this

```swift
    func testProtocol() {
        let client = TestClient()
        client.fireEvent()
    }
```

### Discussion

The above approach works... but it is rather ugly. In cases like this it may be cleaner just doing what `NotificationCenter` does which is pass around a `userInfo` object of type `Any` and let the client cast it into whatever it expects. Like this.

```swift
protocol SupportArticleViewDelegate: AnyObject {
    func didSelectArticle(withURL url: URL, userInfo: Any)
}

class SupportArticleView: UIView {

    var userInfo: Any // placeholder for any info client may want passed back
    
    weak var delegate: SupportArticleViewDelegate?
        
    init(userInfo: Any) {
        self.userInfo = userInfo
        super.init(frame: .zero)
    }

    ...
     delegate?.didSelectArticle(withURL: url, userInfo: userInfo)
    ...
```

Then in the client.

```swift
extension FailureViewController: SupportArticleViewDelegate {

    func didSelectArticle(withURL url: URL, userInfo: Any) {

        guard let analyticsEvent = userInfo as? Analytics.Actions.Activation else { return }

        // do something
    }
```

