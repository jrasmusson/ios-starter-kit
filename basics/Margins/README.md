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

	// constraints
        stack.topAnchor.constraint(equalTo:view.topAnchor).isActive = true
        stack.leadingAnchor.constraint(equalTo:view.leadingAnchor).isActive = true
        stack.trailingAnchor.constraint(equalTo:view.trailingAnchor).isActive = true
        stack.bottomAnchor.constraint(equalTo:view.bottomAnchor).isActive = true
    }

}
```
## safeAreaLayoutGuide

In iOS11 Apple deprecated the top and bottom layout guides and replaced them with the Safe Area layout guides.

```swift
        let margins = view.safeAreaLayoutGuide
        stack.topAnchor.constraint(equalTo: margins.topAnchor).isActive = true
        stack.leadingAnchor.constraint(equalTo: margins.leadingAnchor).isActive = true
        stack.trailingAnchor.constraint(equalTo: margins.trailingAnchor).isActive = true
        stack.bottomAnchor.constraint(equalTo: margins.bottomAnchor).isActive = true
```

<img src="https://github.com/jrasmusson/ios-starter-kit/blob/master/basics/Margins/images/safe.png" alt="drawing" width="400"/>

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

        view.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 100, leading: 8, bottom: 100, trailing: 8) // iOS 11

        let margins = view.safeAreaLayoutGuide

        stack.topAnchor.constraint(equalTo: margins.topAnchor).isActive = true
        stack.leadingAnchor.constraint(equalTo: margins.leadingAnchor).isActive = true
        stack.trailingAnchor.constraint(equalTo: margins.trailingAnchor).isActive = true
        stack.bottomAnchor.constraint(equalTo: margins.bottomAnchor).isActive = true
    }

}
```

I believe the recommended approach now from Apple is to do everything via `view.directionalLayoutMargins`. So don't even use or refer to `view.layoutMargins`. Just set and work padding via the directional way on your view, and go from there.

## Layout & Directional margins

<img src="https://github.com/jrasmusson/ios-starter-kit/blob/master/basics/Margins/images/directional-margin.png" alt="drawing" width="400"/>

The `layoutMargins` property was deprecated on iOS 11 and replaced with `directionalLayoutMargins` to take into account the current language direction. We still use `layoutMarginsGuide` when styling, but we set it via `directionalLayoutMargins` which translates the `CGFloats` into the proper anchors under the hood.

So if you need to set specific insets on a view do it like this.

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

        view.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 100, leading: 8, bottom: 100, trailing: 8) // iOS 11

        let margins = view.layoutMarginsGuide

        stack.topAnchor.constraint(equalTo: margins.topAnchor).isActive = true
        stack.leadingAnchor.constraint(equalTo: margins.leadingAnchor).isActive = true
        stack.trailingAnchor.constraint(equalTo: margins.trailingAnchor).isActive = true
        stack.bottomAnchor.constraint(equalTo: margins.bottomAnchor).isActive = true
    }

}

```

## Summary

So do everything via `topAnchor`, `leadingAnchor`, `trailingAnchor`, `bottomAnchor`. Just vary the layout guide you are using (`layoutMarginsGuide` or `safeAreaLayoutGuide` and adjust via `directionalLayoutMargins`.

```swift

        view.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 100, leading: 8, bottom: 100, trailing: 8) // iOS 11
	
	let margins = view.safeAreaLayoutGuide
        let margins = view.layoutMarginsGuide

        stack.topAnchor.constraint(equalTo: margins.topAnchor).isActive = true
        stack.leadingAnchor.constraint(equalTo: margins.leadingAnchor).isActive = true
        stack.trailingAnchor.constraint(equalTo: margins.trailingAnchor).isActive = true
        stack.bottomAnchor.constraint(equalTo: margins.bottomAnchor).isActive = true
```

Also remember to protect yourself against non iOS 11 versions.

```swift
	if #available(iOS 11, *) {
	    imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
	} else {
	    imageView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
	}
```

### Links that help

* [Apple layout margins](https://developer.apple.com/documentation/uikit/uiview/1622566-layoutmargins)
* [Apple directionalLayoutMargins](https://developer.apple.com/documentation/uikit/uiview/2865930-directionallayoutmargins)
* [Apple safe area](https://developer.apple.com/documentation/uikit/uiview/positioning_content_relative_to_the_safe_area?language=objc)
* [Use your load safe area guide](https://useyourloaf.com/blog/safe-area-layout-guide/)







