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
    
    func didSelectArticle<String>(withEvent event: String) {
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