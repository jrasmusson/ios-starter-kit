# Margins

## No Margins

<img src="https://github.com/jrasmusson/ios-starter-kit/blob/master/basics/Margins/images/no-margins.png" alt="drawing" width="400"/>

```swift
//
//  ViewController.swift
//  LayoutMargins
//
//  Created by Jonathan Rasmusson (Contractor) on 2018-09-10.
//  Copyright © 2018 Jonathan Rasmusson (Contractor). All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()
    }

    func setupViews() {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Hello"
        label.backgroundColor = .green

        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.addArrangedSubview(label)

        view.addSubview(stack)

        stack.topAnchor.constraint(equalTo:view.topAnchor).isActive = true
        stack.leadingAnchor.constraint(equalTo:view.leadingAnchor).isActive = true
        stack.trailingAnchor.constraint(equalTo:view.trailingAnchor).isActive = true
        stack.bottomAnchor.constraint(equalTo:view.bottomAnchor).isActive = true
    }

}
```

## Layout Margins

`layoutOutMargin`s are the default spacing guides used when laying out content.

```swift
var layoutMargins: UIEdgeInsets { get set }```





### Links that help

* [Apple docs](https://developer.apple.com/documentation/uikit/uistackview)


