# UIStatusBar

## AppDelegate

### View Controller

```swift
import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        window?.backgroundColor = .systemBackground
        
        let vc = ViewController()
        let statusBarBackgroundView = UIView.makeStatusBarBackgroundView()
        vc.view.addSubview(statusBarBackgroundView)
        
        window?.rootViewController = vc
        
        return true
    }
}

extension UIView {
    static func makeStatusBarBackgroundView() -> UIView {
        let statusBarSize = UIApplication.shared.statusBarFrame.size // deprecated
        let frame = CGRect(origin: .zero, size: statusBarSize)
        let statusBackgroundView = UIView(frame: frame)
        statusBackgroundView.backgroundColor = .systemPurple
        statusBackgroundView.layer.zPosition = 100
        return statusBackgroundView
    }
}
```

### Navigation Controller

Same view only embedded in the navigationController.

```swift
let navigationController = UINavigationController(rootViewController: ViewController())
let statusBarBackgroundView = UIView.makeStatusBarBackgroundView()
navigationController.view.addSubview(statusBarBackgroundView)
```        

![](images/0.png)

## Misc

```swift
class ActivateViewController: UIViewController {

    override var prefersStatusBarHidden: Bool {
        return false
    }

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}
```

```swift
public enum UIStatusBarStyle : Int {
    case `default` // Dark content, for use on light backgrounds

    @available(iOS 7.0, *)
    case lightContent // Light content, for use on dark backgrounds
}
```


