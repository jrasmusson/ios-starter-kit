# UINavigationController

## Basic

Here is a simple example of how to embed your whole application in a `UINavigationController` and have it present a single screen.

AppDelegate

```swift
     func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()

        let navigatorController = UINavigationController(rootViewController: ViewController())
        window?.rootViewController = navigatorController

        return true
    }
```

Since we are already in a `UINavigationController` in our mainVC, we can either `push` a new `UIViewController` and get a free back button.

```swift
   @objc func nextPressed(sender: UIButton!) {
        self.navigationController?.pushViewController(Page1ViewController(), animated: true)
    }
```

![Push](https://github.com/jrasmusson/ios-starter-kit/blob/master/basics/UINavigationController/images/push.gif)

Or we can present modally and manually dismiss ourselves in the presented viewcontroller.

```swift
    @objc func nextPressed(sender: UIButton!) {
        self.navigationController?.present(Page1ViewController(), animated: true)
    }
```

```swift
    @objc func dismissPressed(sender: UIButton!) {
        dismiss(animated: true, completion: nil)
    }
```

![PresentAndDismiss](https://github.com/jrasmusson/ios-starter-kit/blob/master/basics/UINavigationController/images/dismiss.gif)

### Links that help

[Programmatic UINavigation Controller](https://medium.com/whoknows-swift/swift-the-hierarchy-of-uinavigationcontroller-programmatically-91631990f495)
