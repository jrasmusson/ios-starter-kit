# UINavigationController

## Basics

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

Just remember that because we are on the stack, we need to pop ourselves off to return to root.

```swift
    @objc func dismissPressed(sender: UIButton!) {
        self.navigationController?.popViewController(animated: true)
    }
```

![PresentAndDismiss](https://github.com/jrasmusson/ios-starter-kit/blob/master/basics/UINavigationController/images/dismiss.gif)

## Custom BarButton Items

We can add `UIBarButtonItem`s to our navigation bar.

```swift
    let leftBarButtonItem: UIBarButtonItem = {
        let barButtonItem = UIBarButtonItem(title: "Left Item", style: .plain, target: self, action: #selector(leftTapped))
        barButtonItem.tintColor = UIColor.red
        return barButtonItem
    }()

    let rightBarButtonItem: UIBarButtonItem = {
        let barButtonItem = UIBarButtonItem(title: "Right Item", style: .plain, target: self, action: #selector(rightTapped))
        barButtonItem.tintColor = UIColor.blue
        return barButtonItem
    }()
    
    ...
    
    func setupNavigationBar() {
        self.title = "Login"
        self.navigationItem.rightBarButtonItem = rightBarButtonItem
        self.navigationItem.leftBarButtonItem = leftBarButtonItem
    }

```

## How to change the color of the built in back button

```swift
    @objc func buttonPressed(sender: UIButton!) {
        let navigationController = UINavigationController(rootViewController: Page1ViewController())
        navigationController.navigationBar.tintColor = customBlue()
        present(navigationController, animated: true)
    }
```

## How to hide the bottom pixel on navigation bar

That bottom pixel border you see on the navigation bar is a shadow image. You can make it go away by doing this.

```swift
        let img = UIImage()
        self.navigationController?.navigationBar.shadowImage = img
        self.navigationController?.navigationBar.setBackgroundImage(img, for: .default)
        self.navigationController?.navigationBar.isTranslucent = false
```

<img src="https://github.com/jrasmusson/ios-starter-kit/blob/master/basics/UINavigationController/images/no-border.png" alt="drawing" />

## How to change the title of back button

The title of the back button belongs to the viewController that pushed the current VC onto the stack. Not the viewController you are currently on. So to set the back button title, you need to do it before you push on the previous viewController.

```swift
    @objc func gettingStartedPressed(sender: UIButton!) {
        let backItem = UIBarButtonItem()
        backItem.title = "Foo"
        navigationItem.backBarButtonItem = backItem

        self.navigationController?.pushViewController(Page2ViewController(), animated: true)
    }
 ```
 
 If you want to blank out the text on the back button just set the above title to "".
 
 ## How to hide the back button
 
 This will hide the back button on the `ViewController` you are currently on.
 
 ```swift
 navigationItem.hidesBackButton = true
 ```
 
## How to add an action to a UIBarButtonItem

If you create a `UIBarButtonItem` like this

```swift
    let rightBarButtonItem: UIBarButtonItem = {
        let barButtonItem = UIBarButtonItem(title: "X", style: .plain, target: self, action: nil)
        barButtonItem.tintColor = shawBlue()

        return barButtonItem
    }()
```

Beware that you need to add an `target` and `action` to it like this

```swift
    func setupNavigationBar() {
        rightBarButtonItem.target = self
        rightBarButtonItem.action = #selector(Page1ViewController.dismissPressed(sender: ))
        self.navigationItem.rightBarButtonItem = rightBarButtonItem
    }
    
    @objc func dismissPressed(sender: Any?) {
        print("dismissPressed")
        dismiss(animated: true, completion: nil)
    }
```

That's because when the computed property is created, self is not yet set into a state that can respond to that target in the responder chain. So it never gets fired. But I am not really sure why. Maybe someone can confirm. 

`target: self` pulls you out of the responder chain, but nil passes it on. 

Todo: Google Cocoa Core Competencies - and read about responder chain and delegate.

## How to detect back button pressed

```swift
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        if self.isMovingFromParent {
           // back button pressed
        }
    }

```

### Links that help

* [Programmatic UINavigation Controller](https://medium.com/whoknows-swift/swift-the-hierarchy-of-uinavigationcontroller-programmatically-91631990f495)
