# UIAlertController

## Basics

```swift
import UIKit

class ViewController: UIViewController {
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        showNotificationAlert()
    }

    func showNotificationAlert() {
        let alert = UIAlertController(title: "Notifications Disabled",
                                      message: "For the best chat experience needs notification",
                                      preferredStyle: .alert)

        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        alert.addAction(UIAlertAction(title: "Settings", style: .cancel, handler: nil))

        present(alert, animated: true, completion: nil)
    }
}
```

![TableView](https://github.com/jrasmusson/ios-starter-kit/blob/master/basics/UIAlertController/images/alert.png)

![TableView](https://github.com/jrasmusson/ios-starter-kit/blob/master/basics/UIAlertController/images/action-sheet.png)

![TableView](https://github.com/jrasmusson/ios-starter-kit/blob/master/basics/UIAlertController/images/alert-with-textfield.png)


### Links that help
* [Apple docs](https://developer.apple.com/documentation/uikit/uialertcontroller)
* [Human Interface Guidelines](https://developer.apple.com/design/human-interface-guidelines/ios/views/alerts)
