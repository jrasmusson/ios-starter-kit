# Basic Animation

```
stackView.translatesAutoresizingMaskIntoConstraints = false // #1 rule always set this on every UIView
chatLabel.widthAnchor.constraint(equalToConstant: 200).isActive = true // #2 check constraint is active
```

This examples show basic autolayout apis using a two `UIStackViews` stacked on top of the other.

![Demo](https://github.com/jrasmusson/ios-starter-kit/blob/master/autolayout/basics/images/basics.png)

```swift
//
//  ViewController.swift
//  StackViewStoryboard
//
//  Created by Jonathan Rasmusson (Contractor) on 2018-08-29.
//  Copyright © 2018 Jonathan Rasmusson (Contractor). All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // setup
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false

        // topStackView
        let topStackView = UIStackView()
        topStackView.translatesAutoresizingMaskIntoConstraints = false

        let redView = UIView()
        redView.translatesAutoresizingMaskIntoConstraints = false
        redView.backgroundColor = UIColor.red

        topStackView.addArrangedSubview(redView)

        // bottomStackView
        let bottomStackView = UIStackView()
        bottomStackView.translatesAutoresizingMaskIntoConstraints = false

        let blueView = UIView()
        blueView.translatesAutoresizingMaskIntoConstraints = false
        blueView.backgroundColor = UIColor.blue

        bottomStackView.addArrangedSubview(blueView)

        stackView.addArrangedSubview(topStackView)
        stackView.addArrangedSubview(bottomStackView)

        // constraints
        redView.topAnchor.constraint(equalTo: topStackView.topAnchor).isActive = true
        redView.leadingAnchor.constraint(equalTo: topStackView.leadingAnchor).isActive = true
        redView.trailingAnchor.constraint(equalTo: topStackView.trailingAnchor).isActive = true
        redView.heightAnchor.constraint(greaterThanOrEqualToConstant: 200).isActive = true

        blueView.topAnchor.constraint(equalTo: bottomStackView.topAnchor).isActive = true
        blueView.leadingAnchor.constraint(equalTo: bottomStackView.leadingAnchor).isActive = true
        blueView.trailingAnchor.constraint(equalTo: bottomStackView.trailingAnchor).isActive = true
        blueView.heightAnchor.constraint(equalToConstant: 200).isActive = true

        // stackView
        view.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        stackView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
    }

}

```



### Things to note

* `UIStackView`s by themselves have no background, or height or width. They this all from the `intrinsic size` of their internal elements. That's we the red and blue views need constraints around heights. Otherwise the stacks wouldn't know how big they are.
