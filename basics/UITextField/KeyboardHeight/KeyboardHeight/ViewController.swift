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

