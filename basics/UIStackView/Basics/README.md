# UIStackView Basics

Here is a basic example of `UIStackView` taking into account hugging and compressing.

Let's say we want to build a basic form with a `UILabel` and `UITextField` side-by-side. If we drop a label and text field into a `UIStackView` we get this.

<img src="https://github.com/jrasmusson/ios-starter-kit/blob/master/basics/UIStackView/Basics/images/no-hugging.png" alt="drawing" width="400"/>

```swift
//
//  ViewController.swift
//  StackViewBasic
//
//  Created by Jonathan Rasmusson (Contractor) on 2018-09-05.
//  Copyright © 2018 Jonathan Rasmusson (Contractor). All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()
    }

    func setupViews () {

        // first name stackView
        let firstNameStack = UIStackView()
        firstNameStack.translatesAutoresizingMaskIntoConstraints = false
//        firstNameStack.axis = UILayoutConstraintAxis.horizontal
//        firstNameStack.distribution = UIStackViewDistribution.fillProportionally
//        firstNameStack.alignment = UIStackViewAlignment.center
//        firstNameStack.spacing = 16.0

        let firstNameLabel = UILabel()
        firstNameLabel.translatesAutoresizingMaskIntoConstraints = false
        firstNameLabel.text = "First"
        firstNameLabel.backgroundColor = .red

        let firstNameTextField = UITextField()
        firstNameTextField.translatesAutoresizingMaskIntoConstraints = false
        firstNameTextField.placeholder = "Enter first name"
        firstNameTextField.backgroundColor = .green

        firstNameStack.addArrangedSubview(firstNameLabel)
        firstNameStack.addArrangedSubview(firstNameTextField)

        view.addSubview(firstNameStack)

        NSLayoutConstraint.activate([
            firstNameStack.topAnchor.constraint(equalTo: view.topAnchor, constant: 20),
            firstNameStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            firstNameStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            ])
    }
}
```



### Links that help

* [Apple docs](https://developer.apple.com/documentation/uikit/uistackview)

