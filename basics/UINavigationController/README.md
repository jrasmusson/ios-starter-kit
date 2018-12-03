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

## BarButton Items

We can add `UIBarButtonItem`s to our navigation bar.

```swift
    let leftBarButtonItem: UIBarButtonItem = {
        let barButtonItem = UIBarButtonItem(title: "Left Item", style: .plain, target: self, action: nil)
        barButtonItem.tintColor = UIColor.red
        return barButtonItem
    }()

    let rightBarButtonItem: UIBarButtonItem = {
        let barButtonItem = UIBarButtonItem(title: "Right Item", style: .plain, target: self, action: nil)
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

Just remember that because we are on the stack, we need to pop ourselves off to return to root.

```swift
    @objc func dismissPressed(sender: UIButton!) {
        self.navigationController?.popViewController(animated: true)
    }
```

![PresentAndDismiss](https://github.com/jrasmusson/ios-starter-kit/blob/master/basics/UINavigationController/images/pop.gif)

### Source Code

```swift
import UIKit

class ViewController: UIViewController {

    let titleLabel: UILabel = {
        let label = makeLabel()
        label.text = "Main Page"

        return label
    }()

    let nextButton: UIButton = {
        let button = makeButton()
        button.setTitle("Next", for: .normal)
        button.addTarget(self, action: #selector(nextPressed), for: .touchUpInside)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()
    }

    func setupViews() {
        view.backgroundColor = .white

        view.addSubview(titleLabel)
        view.addSubview(nextButton)

        titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20).isActive = true

        nextButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        nextButton.topAnchor.constraint(equalTo: titleLabel.topAnchor, constant: 20).isActive = true
    }

    @objc func nextPressed(sender: UIButton!) {
        self.navigationController?.pushViewController(Page1ViewController(), animated: true)
    }
}
```

```swift
import UIKit

class Page1ViewController: UIViewController {

    let titleLabel: UILabel = {
        let label = makeLabel()
        label.text = "Page1"

        return label
    }()

    let dismissButton: UIButton = {
        let button = makeButton()
        button.setTitle("Dismiss", for: .normal)
        button.addTarget(self, action: #selector(dismissPressed), for: .touchUpInside)
        return button
    }()

    let leftBarButtonItem: UIBarButtonItem = {
        let barButtonItem = UIBarButtonItem(title: "Left Item", style: .plain, target: self, action: nil)
        barButtonItem.tintColor = UIColor.red
        return barButtonItem
    }()

    let rightBarButtonItem: UIBarButtonItem = {
        let barButtonItem = UIBarButtonItem(title: "Right Item", style: .plain, target: self, action: nil)
        barButtonItem.tintColor = UIColor.blue
        return barButtonItem
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()
        setupNavigationBar()
    }

    func setupViews() {
        view.backgroundColor = .white

        view.addSubview(titleLabel)
        view.addSubview(dismissButton)

        titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20).isActive = true
        dismissButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        dismissButton.topAnchor.constraint(equalTo: titleLabel.topAnchor, constant: 20).isActive = true
    }

    func setupNavigationBar() {
        self.title = "Login"
        self.navigationItem.rightBarButtonItem = rightBarButtonItem
        self.navigationItem.leftBarButtonItem = leftBarButtonItem
    }

    @objc func dismissPressed(sender: UIButton!) {
//        dismiss(animated: true, completion: nil)
        self.navigationController?.popViewController(animated: true)
    }

}

func makeLabel() -> UILabel {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.text = "Title"
    label.textAlignment = .center
    label.textColor = .black
    label.font = UIFont.systemFont(ofSize: 18)
    label.numberOfLines = 0

    return label
}

func makeButton() -> UIButton {
    let button = UIButton()
    button.translatesAutoresizingMaskIntoConstraints = false
    button.backgroundColor = .lightGray
    button.setTitleColor(.black, for: .normal)

    return button
}
```

### Links that help

[Programmatic UINavigation Controller](https://medium.com/whoknows-swift/swift-the-hierarchy-of-uinavigationcontroller-programmatically-91631990f495)
