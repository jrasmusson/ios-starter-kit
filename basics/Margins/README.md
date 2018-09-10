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

## Layout & Directional margins

The layout margin is he default spacing qw use when laying out content in the view.

In iOS 11 and later, use the `directionalLayoutMargins` (top, bottom, leading, trailing) property to specify layout margins instead of this property. The leading and trailing edge insets in the directionalLayoutMargins property are synchronized with the left and right insets in this property. For example, setting the leading directional edge inset to 20 points causes the left inset of this property to be set to 20 points on a system with a left-to-right language.

```swift

    let margins = view.layoutMarginsGuide
    stack.topAnchor.constraint(equalTo: margins.topAnchor).isActive = true
    stack.leadingAnchor.constraint(equalTo: margins.leadingAnchor).isActive = true
    stack.trailingAnchor.constraint(equalTo: margins.trailingAnchor).isActive = true
    stack.bottomAnchor.constraint(equalTo: margins.bottomAnchor).isActive = true

```

<img src="https://github.com/jrasmusson/ios-starter-kit/blob/master/basics/Margins/images/margins.png" alt="drawing" width="400"/>

You can change the layout margin like this

```swift
view.layoutMargins = UIEdgeInsets(top: 32, left: 64, bottom: 32, right: 64)
```

<img src="https://github.com/jrasmusson/ios-starter-kit/blob/master/basics/Margins/images/custom-margin.png" alt="drawing" width="400"/>

Or the directional layout margin like this

```swift
view.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 100, leading: 8, bottom: 100, trailing: 8)
```

<img src="https://github.com/jrasmusson/ios-starter-kit/blob/master/basics/Margins/images/directional-margin.png" alt="drawing" width="400"/>

But if you try both

```swift
        view.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 100, leading: 8, bottom: 100, trailing: 8)
        view.layoutMargins = UIEdgeInsets(top: 32, left: 64, bottom: 32, right: 64)
        
        let margins = view.layoutMarginsGuide
        
        stack.topAnchor.constraint(equalTo: margins.topAnchor).isActive = true
        stack.leadingAnchor.constraint(equalTo: margins.leadingAnchor).isActive = true
        stack.trailingAnchor.constraint(equalTo: margins.trailingAnchor).isActive = true
        stack.bottomAnchor.constraint(equalTo: margins.bottomAnchor).isActive = true
```

The layout margin appears to win. So pick one (probably directional) and set via it.

<img src="https://github.com/jrasmusson/ios-starter-kit/blob/master/basics/Margins/images/both.png" alt="drawing" width="400"/>


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

Full code

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

        view.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 100, leading: 8, bottom: 100, trailing: 8)
        view.layoutMargins = UIEdgeInsets(top: 32, left: 64, bottom: 32, right: 64)

        let margins = view.layoutMarginsGuide
        let margins = view.safeAreaLayoutGuide

        stack.topAnchor.constraint(equalTo: margins.topAnchor).isActive = true
        stack.leadingAnchor.constraint(equalTo: margins.leadingAnchor).isActive = true
        stack.trailingAnchor.constraint(equalTo: margins.trailingAnchor).isActive = true
        stack.bottomAnchor.constraint(equalTo: margins.bottomAnchor).isActive = true
    }

}
```

### Links that help

* [Apple layout margins](https://developer.apple.com/documentation/uikit/uiview/1622566-layoutmargins)
* [Apple directionalLayoutMargins](https://developer.apple.com/documentation/uikit/uiview/2865930-directionallayoutmargins)
* [Apple safe area](https://developer.apple.com/documentation/uikit/uiview/positioning_content_relative_to_the_safe_area?language=objc)
* [Use your load safe area guide](https://useyourloaf.com/blog/safe-area-layout-guide/)







