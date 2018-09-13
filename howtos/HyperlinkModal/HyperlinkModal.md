# Hyperlink Modal

This recipe show you how to make a modal `ViewController` appear by clicking on some text in a `UITextView`. 

![Demo](https://github.com/jrasmusson/ios-starter-kit/blob/master/recipes/HyperlinkModal/images/demo.gif)

```swift
//
//  ViewController.swift
//  HyperlinkModal
//
//  Created by Jonathan Rasmusson (Contractor) on 2018-08-21.
//  Copyright © 2018 Jonathan Rasmusson (Contractor). All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var textView: UITextView!

    override func viewDidLoad() {
        super.viewDidLoad()

        // You must set the formatting of the link manually
        let linkAttributes: [NSAttributedStringKey: Any] = [
            .link: NSURL(string: "https://www.apple.com")!,
            .foregroundColor: UIColor.blue
        ]

        let attributedString = NSMutableAttributedString(string: "Just click here to register")

        // Set the 'click here' substring to be the link
        attributedString.setAttributes(linkAttributes, range: NSMakeRange(5, 10))

        textView.delegate = self
        textView.attributedText = attributedString
        textView.isUserInteractionEnabled = true
        textView.isEditable = false
    }

}

extension ViewController: UITextViewDelegate {

    func textView(_ textView: UITextView, shouldInteractWith URL: URL, in characterRange: NSRange, interaction: UITextItemInteraction) -> Bool {

        let bluey = UIViewController()
        bluey.view.backgroundColor = UIColor.blue

        // animate from right
        self.navigationController?.present(bluey, animated: true, completion: nil)

        // animate from bottom
        self.navigationController?.pushViewController(bluey, animated: true)

        return false
    }

}
```


### Links that help

* [StackOverflow](https://stackoverflow.com/questions/39238366/uitextview-with-hyperlink-text)

