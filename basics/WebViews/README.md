# WebViews

There are three ways to display web views in iOS

* Mobile Safari
* WKWebView
* SFSafariViewController

## Mobile Safari

The simplest, this simply opens a link in the Safari browser.

<img src="https://github.com/jrasmusson/ios-starter-kit/blob/master/basics/WebViews/images/MobileSafari.png" alt="drawing" width="400"/>


```swift
import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        guard let url = URL(string: "https://apple.com") else { return }
        UIApplication.shared.open(url)
    }

}
```

## WKWebView

Use `WKWebView` when you want to embed a webview in some other view. It offers no browser experience. Simply shows the page.

<img src="https://github.com/jrasmusson/ios-starter-kit/blob/master/basics/WebViews/images/WKWebView.png" alt="drawing" width="400"/>

```swift
import UIKit
import WebKit

class ViewController: UIViewController, WKUIDelegate {

    var webView: WKWebView!

    override func loadView() {
        let webConfiguration = WKWebViewConfiguration()
        webView = WKWebView(frame: .zero, configuration: webConfiguration)
        webView.uiDelegate = self
        view = webView
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        let myURL = URL(string:"https://www.apple.com")
        let myRequest = URLRequest(url: myURL!)
        webView.load(myRequest)
    }

}
```

## SFSafariViewController

This is a full on web browser as a ViewController.

<img src="https://github.com/jrasmusson/ios-starter-kit/blob/master/basics/WebViews/images/SFSafariViewController.png" alt="drawing" width="400"/>

```swift
import UIKit
import SafariServices

class ViewController: UIViewController , SFSafariViewControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()
    }

    func setupViews() {
        view.backgroundColor = .white

        let url = URL(string: "https://apple.com")!
        let safariController = SFSafariViewController(url: url)

        present(safariController, animated: true)

        safariController.delegate = self
    }

}
```

Note: This ViewController needs to be embedded in something that can present a ViewController (i.e. a UINavigationController). 

```swift
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()

        let navigatorController = UINavigationController(rootViewController: ViewController())
        window?.rootViewController = navigatorController

        return true
    }
```

### Links that help
* [Apple docs](https://developer.apple.com/documentation/webkit/wkwebview)
