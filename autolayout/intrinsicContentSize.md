# IntrinsicContentSize

This is a super important topic for when you need to build custom views. Autolayout won't know the size of your custom view unless you tell it. You don't want to explicitly set height and width in the custom view itself (that would keep it from expanding or growing). But you can set it's size using `instrinsicContentSize` like this.


```swift
// RoundContainer.swift
import UIKit

final class RoundContainer: UIView {

    var cornerRadius: CGFloat = 10.0 {
        didSet {
            layer.cornerRadius = cornerRadius
        }
    }

    override var intrinsicContentSize: CGSize {
        return CGSize(width: cornerRadius * 2, height: cornerRadius * 2)
    }
}
```

```swift
// ViewController.swift
import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()
    }

    func setupViews() {
        let container = RoundContainer()
        container.backgroundColor = .orange
        container.cornerRadius = 20
        container.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(container)

        container.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        container.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }

}
```

<img src="https://github.com/jrasmusson/ios-starter-kit/blob/master/autolayout/images/intrinsic.png" />


### Links that help

* [Apple Docs1](https://developer.apple.com/documentation/uikit/uiview/1622600-intrinsiccontentsize)
* [Apple Docs2](https://developer.apple.com/library/archive/documentation/UserExperience/Conceptual/AutolayoutPG/ViewswithIntrinsicContentSize.html)
* [Apple Docs3](https://developer.apple.com/library/archive/documentation/UserExperience/Conceptual/AutolayoutPG/AnatomyofaConstraint.html#//apple_ref/doc/uid/TP40010853-CH9-SW21)
* [Example1](https://medium.com/@vialyx/import-uikit-what-is-intrinsic-content-size-20ae302f21f3)
* [Example2](https://blog.usejournal.com/custom-uiview-in-swift-done-right-ddfe2c3080a)
