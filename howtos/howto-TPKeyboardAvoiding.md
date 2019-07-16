# How to TPKeyboardAvoiding

This library deals with the popping up keyboard problem by putting your view into a scrollable view. Note: It doesn't adjust your layout - if you want to do that you still need to calculate the keyboard and do that yourself. But it's a good solution for making your view scrollable when the keyboard appears and it quite popular.

![TableView](https://github.com/jrasmusson/ios-starter-kit/blob/master/howtos/images/TPKeyboardAvoiding-demo.gif)

```swift
> pod init
> pod 'TPKeyboardAvoiding', '~> 1.3'
> pod install
```

```swift
//
//  ViewController.swift
//  Foo
//
//  Created by Jonathan Rasmusson (Contractor) on 2019-07-16.
//  Copyright © 2019 Jonathan Rasmusson. All rights reserved.
//

import UIKit
import TPKeyboardAvoiding

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }

    func setupViews() {
        let textField = makeTextField()
        let scrollView = makeScrollView()
        let middle = makeButton(title: "Middle")

        view.addSubview(scrollView)

        scrollView.addSubview(textField)
        scrollView.addSubview(middle)

        scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true

        textField.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 8).isActive = true
        textField.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 8).isActive = true

        middle.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        middle.centerYAnchor.constraint(equalTo: scrollView.centerYAnchor).isActive = true
    }

    func makeTextField() -> UITextField {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.text = "Password"
        textField.backgroundColor = .yellow

        return textField
    }

    func makeScrollView() -> TPKeyboardAvoidingScrollView {
        let scrollView = TPKeyboardAvoidingScrollView(frame: .zero)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.alwaysBounceVertical = true
        scrollView.showsVerticalScrollIndicator = false

        return scrollView
    }

    func makeButton(title: String) -> UIButton {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle(title, for: .normal)
        button.contentEdgeInsets = UIEdgeInsets.init(top: 8, left: 16, bottom: 8, right: 16)
        button.backgroundColor = .blue

        return button
    }
}
```


### Links

- [TPKeyboardAvoiding](https://github.com/michaeltyson/TPKeyboardAvoiding)
- [Cocoa Pod](https://cocoapods.org/pods/TPKeyboardAvoiding)
