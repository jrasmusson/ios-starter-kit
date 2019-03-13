# Responder Chain

<img src="https://github.com/jrasmusson/ios-starter-kit/blob/master/advanced/images/responder-chain.png" alt="drawing" width="600"/>

The responder chain is an eventing mechanism Mac and iOS programs use for firing events up the UI hierarchy and having others listening for them.

It's more dominant in Mac OS programming (where you don't always have a 1:1 relationship between a ViewController and it's controls). But it can also be used in iOS programming as an alternative to the protocol delegate pattern.

## Example of chain

This example shows how a responder chain event goes from View to ViewController to Window to AppDelegate.

```swift
import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        return true
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        print("AppDelegate: touchesBegan")
    }

}
```

```swift
import UIKit

extension UIView {
    override open func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        print("UIView: touchesBegan")
        next?.touchesBegan(touches, with: event)
    }
}

extension UIWindow {
    override open func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        print("UIWindow: touchesBegan")
        next?.touchesBegan(touches, with: event)
    }
}

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override open func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        print("UIViewController: touchesBegan")
        next?.touchesBegan(touches, with: event)
    }

}
```

<img src="https://github.com/jrasmusson/ios-starter-kit/blob/master/advanced/images/responder-chain-action.png" alt="drawing" width="400"/>


## Example in app

This example shows how to fire an event responder from a `UIViewController` and then pick it up somewhere else like the `AppDelegate`.

> Note You must set target to `nil` to fire up responder chain.

```swift
import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }

    func setupViews() {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Fire event", for: .normal)
        button.addTarget(nil, action: #selector(AppDelegate.dismissPressed), for: .touchUpInside)

        view.addSubview(button)

        button.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        button.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }

}
```

```swift
import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        return true
    }

    @objc func dismissPressed(sender: Any?) {
        print("AppDelegate: dismissPressed")
    }

}
```

<img src="https://github.com/jrasmusson/ios-starter-kit/blob/master/advanced/images/responder-chain-button.png" alt="drawing" width="400"/>

## Example with Protocol

An even better way to do this is with protocols.

```swift
@objc protocol ButtonPressable: AnyObject {
    func buttonPressed(sender: Any?)
}

class ViewController: UIViewController {
    func setupViews() {
        ...
        button.addTarget(nil, action: #selector(ButtonPressable.buttonPressed), for: .touchUpInside)
        ...
    }
}
```

```swift
class AppDelegate: UIResponder, UIApplicationDelegate, ButtonPressable {

    func buttonPressed(sender: Any?) {
        print("\nAppDelegate: buttonPressed")
    }

}
```

## How to fire event programmatically

```swift
UIApplication.shared.sendAction(#selector(PayBillUserActions.performConfirmPayBillAction), to: nil, from: self, for: nil)
```

### Links that help

* [Apple docs](https://developer.apple.com/documentation/uikit/touches_presses_and_gestures/using_responders_and_the_responder_chain_to_handle_events)
* [Example](http://swiftandpainless.com/utilize-the-responder-chain-for-target-action/)
