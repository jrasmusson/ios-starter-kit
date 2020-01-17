# UIAlertController

## Basics

```swift
func showNotificationAlert() {
    let alert = UIAlertController(title: "Notifications Disabled",
                                  message: "For the best chat experience needs notification",
                                  preferredStyle: .alert)

    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (_) in

    }))

    alert.addAction(UIAlertAction(title: "Settings", style: .cancel, handler: { [weak self] (_) in

    }))

    present(alert, animated: true, completion: nil)
}
```

## More

```swift
import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func buttonPressed(_ sender: UIButton) {
        
        var alert: UIAlertController! = nil
        
        if sender.titleLabel?.text == "Alert" {
           alert = UIAlertController(title: "Title", message: "Simple message", preferredStyle: .alert)
        } else {
           alert = UIAlertController(title: "Title", message: "Simple message", preferredStyle: .actionSheet)
        }
        
        let defaultAction = UIAlertAction(title: "Default", style: .default) { (action:UIAlertAction) in
            // nop
        }
        
        let destructiveAction = UIAlertAction(title: "Destructive", style: .destructive) { (action:UIAlertAction) in
            // nop
        }

        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (action:UIAlertAction) in
            // nop
        }
        
        alert.addAction(defaultAction)
        alert.addAction(destructiveAction)
        alert.addAction(cancelAction)
        
        // Note: You can optional choose which alert bold by making it preferred
        // alert.preferredAction = destructiveAction
        
        present(alert, animated: true, completion: nil)
    }
    
    @IBAction func customButtonPressed(_ sender: UIButton) {
        // Can add text fields to alerts
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New Category", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add", style: .default) { (action) in
            
            let newCategory = Category()
            newCategory.name = textField.text!
            
            // save results
        }
        
        alert.addAction(action)
        
        alert.addTextField { (field) in
            textField = field
            textField.placeholder = "Add a new category"
        }
        
        present(alert, animated: true, completion: nil)
    }
    
    private class Category {
        var name: String = ""
    }
}

```

![TableView](https://github.com/jrasmusson/ios-starter-kit/blob/master/basics/UIAlertController/images/alert.png)

![TableView](https://github.com/jrasmusson/ios-starter-kit/blob/master/basics/UIAlertController/images/action-sheet.png)

![TableView](https://github.com/jrasmusson/ios-starter-kit/blob/master/basics/UIAlertController/images/alert-with-textfield.png)


### Links that help
* [Apple docs](https://developer.apple.com/documentation/uikit/uialertcontroller)
* [Human Interface Guidelines](https://developer.apple.com/design/human-interface-guidelines/ios/views/alerts)
