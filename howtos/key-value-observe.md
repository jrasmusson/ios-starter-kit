# Key-Value Observering (KVO)

[KVO](https://developer.apple.com/library/archive/documentation/General/Conceptual/DevPedia-CocoaCore/KVO.html#//apple_ref/doc/uid/TP40008195-CH16-SW1) is a mechanism that enables an oject to be notified directly when a property of another object changes. Important factor in chhesiveness of an application. it is a mode of communciation between objects in applications designed in conformance with MVC.

Can use it to synchronize the state of model objects with objects in the view and controller layers. Typically, controller objects observe model objects, and views observe controller or model objects.

## Implementing KVO

To implement make sure the object you want to observe extends `NSObject`.

```swift
class ViewModel: NSObject {

```

The property you want to observe is `dynamic` and available to the `@objc` runtime.

```swift
@objc dynamic var shawGoWifiAppInstalled: Bool = false
```

Keep track of the observation in the observer class.

```swift
var observation: Any?
```

Observe it like this.

```swift
observation = viewModel.observe(\.isAppInstalled, options: [.initial, .new], changeHandler: appInstalledDidChange(viewModel:observedChange:))
```

And then react to the change.

```swift
func appInstalledDidChange(viewModel: ViewModel, observedChange: NSKeyValueObservedChange<Bool>) {

}
```

## Simple buttons

![](images/simple-kvo.gif)!

```swift
//
//  ViewController.swift
//  Observable
//
//  Created by Jonathan Rasmusson (Contractor) on 2020-11-13.
//

import UIKit

// 1 Extend NSObject
class ViewModel: NSObject {

    // 2 Make a property observable
    @objc dynamic var isAppInstalled: Bool = false

    override init() {
        super.init()
    }
}

class ViewController: UIViewController {

    let useWifiButton = makeButton(withText: "Use App")
    let downloadWifiButton = makeButton(withText: "Download App")
    let toggleButton = makeButton(withText: "Toggle")

    let stackView = makeVerticalStackView()

    var viewModel = ViewModel()
    
    // 3 Track the observation
    var observation: Any?

    override func viewDidLoad() {
        super.viewDidLoad()

        setup()
        layout()

        // 4 Observe it
        observation = viewModel.observe(\.isAppInstalled, options: [.initial, .new], changeHandler: appInstalledDidChange(viewModel:observedChange:))
    }

    // 5 Update when changed
    func appInstalledDidChange(viewModel: ViewModel, observedChange: NSKeyValueObservedChange<Bool>) {
        if viewModel.isAppInstalled {
            useWifiButton.backgroundColor = .systemBlue
            downloadWifiButton.backgroundColor = .systemGray3
        } else {
            useWifiButton.backgroundColor = .systemGray3
            downloadWifiButton.backgroundColor = .systemBlue
        }
    }

    func setup() {
        toggleButton.addTarget(self, action: #selector(togglePressed), for: .touchUpInside)
        toggleButton.backgroundColor = .systemYellow
    }

    func layout() {
        stackView.addArrangedSubview(useWifiButton)
        stackView.addArrangedSubview(downloadWifiButton)
        stackView.addArrangedSubview(toggleButton)

        view.addSubview(stackView)

        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
    }

    @objc func togglePressed() {
        viewModel.isAppInstalled = !viewModel.isAppInstalled
    }
}

func makeButton(withText text: String) -> UIButton {
    let button = UIButton()
    button.translatesAutoresizingMaskIntoConstraints = false
    button.setTitle(text, for: .normal)
    button.titleLabel?.adjustsFontSizeToFitWidth = true
    button.contentEdgeInsets = UIEdgeInsets(top: 8, left: 16, bottom: 8, right: 16)
    button.backgroundColor = .systemBlue
    button.layer.cornerRadius = 8
    return button
}

func makeVerticalStackView() -> UIStackView {
    let stack = UIStackView()
    stack.translatesAutoresizingMaskIntoConstraints = false
    stack.axis = .vertical
    stack.spacing = 8.0

    return stack
}
```

## How does it work - Key-Value Coding

Under the hood KVO uses KVC to make all the accessing of properties and attributes happen. We don't do string comparision in Swift because in Swift we have a more type safe compiler checking Key Path mechanism which lets us leverage KVC in a more type safe way.

```swift
class Child: NSObject {
    @objc dynamic var name: String!

    override init() {
        self.name = ""
        super.init()
    }
}

var child = Child()

child.setValue("Jonathan", forKey: "name")
child.name
```

## Use case for KVO

A nice use case for this is if when you don't know whether someone has an app installed on their phone and you want to update a view depending upon whether they do. Same code as above, just with a notification that fires when the app loads checking to see if the app is installed.

```swift
class ViewModel: NSObject {

     @objc dynamic var shazamInstalled: Bool = false
     var observers: [Any] = []

     override init() {
         super.init()
         shazamInstalled = ShazamUtils.hasShazam()

         let notificationObserver = NotificationCenter.default.addObserver(forName: UIApplication.didBecomeActiveNotification, object: nil, queue: nil) { [weak self] (_) in
             self?.shazamInstalled = ShazamUtils.hasShazam()
         }

         observers.append(notificationObserver)
     }
}


import Foundation

struct ShazamUtils {

 public static let shawGoWifiURL = URL(string: "shazam://")!
 public static func hasShazam() -> Bool {
     return UIApplication.shared.canOpenURL(ShazamUtils.shawGoWifiURL)
 }

}
```





Main difference between Objective-C and Swift is Swift has a more type safe way of doing KVC - it uses KeyPath. Which representings the attribute String as a type safe object in Swift.

### Links that help

- [KVO in Swift](https://developer.apple.com/documentation/swift/cocoa_design_patterns/using_key-value_observing_in_swift)
- [Cocoa Core Competencies](https://developer.apple.com/library/archive/documentation/General/Conceptual/DevPedia-CocoaCore/KVO.html#//apple_ref/doc/uid/TP40008195-CH16-SW1)


