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

## Can the superview override the intrinsic content size?

Yes. This is how intrinsic content size works. `UILabel` has an intrinsicContentSize. But we always stretch and adjust `UILabel`s with contraints. We override it's intrinsic content size. 

And that's a good rule of thumb. As a general rule of thumb *a custom view should never create a constraint for it's own width and height*. When we set `intrinsicContentSize`s we aren't setting contraints. We are adjusting CHCR - hugging and compressing.

Here are the Compression-Resistance and Content-Hugging equations

```swift
// Compression Resistance
View.height >= 0.0 * NotAnAttribute + IntrinsicHeight
View.width >= 0.0 * NotAnAttribute + IntrinsicWidth
 
// Content Hugging
View.height <= 0.0 * NotAnAttribute + IntrinsicHeight
View.width <= 0.0 * NotAnAttribute + IntrinsicWidth
```

That's what let's use constrain the size of our customer view, but not constrain it. The super view does the constraining. The customer the suggesting.

So if we wanted to override our orange dot instrinsic size in the superview, all we have to do is something like this.

```swift
        container.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8).isActive = true
        container.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8).isActive = true

//        container.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        container.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
```

<img src="https://github.com/jrasmusson/ios-starter-kit/blob/master/autolayout/images/intrinsic-overriden.png" />


## What if I want width to expand?

Then don't specify.

```swift
    override public var intrinsicContentSize: CGSize {
        return CGSize(width: UIView.noIntrinsicMetric, height: 28)
    }
```

## How can I see what a views intrinsicContentSize is?

```swift
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        print("view intrinsic content size: \(view.intrinsicContentSize)")
        print("titleLabel intrinsic content size: \(titleLabel.intrinsicContentSize)")
    }
 ```


### Links that help

* [Apple Docs - Intrinsic Content Size](https://developer.apple.com/documentation/uikit/uiview/1622600-intrinsiccontentsize)
* [Apple Docs - Views with intrinsic content size](https://developer.apple.com/library/archive/documentation/UserExperience/Conceptual/AutolayoutPG/ViewswithIntrinsicContentSize.html)
* [Apple Docs - Intrinsic Content Size Equations](https://developer.apple.com/library/archive/documentation/UserExperience/Conceptual/AutolayoutPG/AnatomyofaConstraint.html#//apple_ref/doc/uid/TP40010853-CH9-SW21)
* [Example1](https://medium.com/@vialyx/import-uikit-what-is-intrinsic-content-size-20ae302f21f3)
* [Example2](https://blog.usejournal.com/custom-uiview-in-swift-done-right-ddfe2c3080a)
* [Example3](https://samwize.com/2017/11/01/guide-to-creating-custom-uiview/)
