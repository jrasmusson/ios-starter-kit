# UITextField

`UITextField` it a basic `UIKit` control for entering text. When the user taps, a keyboard appears. Too dismiss the keyboard, call `resignFirstResponder` directly on the `UITextField`.

![Dismiss keyboard](https://github.com/jrasmusson/ios-starter-kit/blob/master/basics/UITextField/images/dismissing-keyboard.gif)

**ViewController.swift**



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

## endEditting vs resignFirstResponder

Another way to dismiss the keyboard is to call `endEditting` on a `UIView` containing a `UITextField`. Which is better?

resignFirstResponder() is good when you know which text field has the keyboard. It’s direct. It’s efficient. Use it when you have the `UITextField` causing the keyboard to appear and you want to give it up.

`endEditing` is actually a method on the `UIView`. Use this when you don’t know who caused the keyboard to appear or you don’t have reference to the `UITextField` currenty in focus. It searches all the subviews in the view hierarchy until it finds the one holding the first responder status and then asks it to give it up. Not as efficient. But it works too (just more broadly).

## Different keyboards 

iOS lets you choose from a vareity of keyboards when accepting user input. Simply change the `keyboardType` on `UITextField` set display various kinds.

![Numbers and URL](https://github.com/jrasmusson/ios-starter-kit/blob/master/basics/UITextField/images/numbersAndPunctuation-URL.png)

![NumberPad and PhonePad](https://github.com/jrasmusson/ios-starter-kit/blob/master/basics/UITextField/images/numberPad-phonePad.png)

![NamePhonePad and Email address](https://github.com/jrasmusson/ios-starter-kit/blob/master/basics/UITextField/images/namePhonePad-emailAddress.png)

```
        textField.keyboardType = UIKeyboardType.emailAddress

//        case `default` // Default type for the current input method.
//
//        case asciiCapable // Displays a keyboard which can enter ASCII characters
//
//        case numbersAndPunctuation // Numbers and assorted punctuation.
//
//        case URL // A type optimized for URL entry (shows . / .com prominently).
//
//        case numberPad // A number pad with locale-appropriate digits (0-9, ۰-۹, ०-९, etc.). Suitable for PIN entry.
//
//        case phonePad // A phone pad (1-9, *, 0, #, with letters under the numbers).
//
//        case namePhonePad // A type optimized for entering a person's name or phone number.
//
//        case emailAddress // A type optimized for multiple email address entry (shows space @ . prominently).
```

## How to adjust view when keyboard present

When the keyboard appears, you may need to adjust your current view layout  to prevent certain elements from being obstructed.

![keyboard disappear](https://github.com/jrasmusson/ios-starter-kit/blob/master/basics/UITextField/images/keyboard-disappear.png)


One way to handle this is to

* create a default height constraint 
* calculate the size of the keyboard
* and then update that constraint to include the original height + the keyboard height

The example below shows you how to do this.

```swift
//
//  ViewController.swift
//  keyboardHeight
//
//  Created by Jonathan Rasmusson (Contractor) on 2018-07-27.
//  Copyright © 2018 Jonathan Rasmusson (Contractor). All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var textField: UITextField!
    @IBOutlet var heightConstraint: NSLayoutConstraint!

    let defaultHeight = CGFloat(20)
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {

        NotificationCenter.default.addObserver(self, selector: #selector(adjustForKeyboard), name: Notification.Name.UIKeyboardWillHide, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(adjustForKeyboard), name: Notification.Name.UIKeyboardWillChangeFrame, object: nil)

        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard(gesture:))))
    }

    override func viewWillDisappear(_ animated: Bool) {
        NotificationCenter.default.removeObserver(self)
    }

    @objc func adjustForKeyboard(notification: Notification) {

        let userInfo = notification.userInfo!

        let keyboardScreenEndFrame = (userInfo[UIKeyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        let keyboardViewEndFrame = view.convert(keyboardScreenEndFrame, from: view.window)
        let keyboardHeight = keyboardViewEndFrame.height

        if notification.name == Notification.Name.UIKeyboardWillHide {
            heightConstraint.constant = defaultHeight
        } else {
            heightConstraint.constant = defaultHeight + keyboardHeight
        }

    }

    @objc func dismissKeyboard(gesture: UIGestureRecognizer) {
        textField?.resignFirstResponder()
    }
}
```

### Links that help
* [Apple docs](https://developer.apple.com/documentation/uikit/uitextfield?changes=_5)
* [Human Interface Guidelines](https://developer.apple.com/design/human-interface-guidelines/ios/controls/text-fields/)