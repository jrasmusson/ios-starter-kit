# UITabBarViewController

## Basic

```swift
import UIKit

class ViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }

    func setupViews() {
        view.backgroundColor = .white

        let firstViewController = ViewController1()

        firstViewController.tabBarItem = UITabBarItem(tabBarSystemItem: .search, tag: 0)

        let secondViewController = ViewController2()

        secondViewController.tabBarItem = UITabBarItem(tabBarSystemItem: .more, tag: 1)

        let tabBarList = [firstViewController, secondViewController]

        viewControllers = tabBarList
    }
}

class ViewController1: UIViewController {
    override func viewDidLoad() {
        view.backgroundColor = .red
    }
}

class ViewController2: UIViewController {
    override func viewDidLoad() {
        view.backgroundColor = .blue
    }
}
```

![TableView](https://github.com/jrasmusson/ios-starter-kit/blob/master/basics/UIScrollView/images/demo.gif)

### Links that help

* [Apple docs](https://developer.apple.com/documentation/uikit/uitabbarcontroller)

