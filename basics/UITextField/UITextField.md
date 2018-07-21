# UITextField

**ViewController.swift**

![Dismiss keyboard](https://github.com/jrasmusson/ios-starter-kit/blob/master/basics/UITextField/images/dismissing-keyboard.gif)

With the `UITextField` you get the keyboard for free by tapping on it. Two ways to dismiss the keyboard are by calling `resignFirstResponder` directly on the `UITextField`. Or you can create a tap gesture, tap anywhere in the view, and give up the first responder from there.

The most direct way to give up the keyboard is to call `textField.resignFirstResponder()`. But if you don't have a reference to the `UITextField` and you are somewhere else in your view, you can also call `view.endEditing(true)` which will scan the entire view hierarchy until it finds a firstResponder and then dismiss it from there.

Here is a simple example showing both techniques.

```swift
//
//  ViewController.swift
//  UITextField
//
//  Created by Jonathan Rasmusson Work Pro on 2018-07-21.
//  Copyright © 2018 Rasmusson Software Consulting. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var textField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // dismiss keyboard via tap gesture
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(viewTapped))
        view.addGestureRecognizer(tapGesture)
    }

    @objc func viewTapped() {
        view.endEditing(true)
    }
    
    // or by giving up first responder
    @IBAction func buttonPressed(_ sender: UIButton) {
        textField.resignFirstResponder()
    }
    
    // Note: `view.endEditing(true)` scans entire view until if finds first responder to resign
    //       `textField.resignFirstResponder()` is a more direct call to the textfield itself
}
```


### Links that help
* [Apple docs](https://developer.apple.com/documentation/uikit/uitextfield?changes=_5)
* [Human Interface Guidelines](https://developer.apple.com/design/human-interface-guidelines/ios/controls/text-fields/)