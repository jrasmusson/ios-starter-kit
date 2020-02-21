# IntrinsicContentSize

```swift
    override public var intrinsicContentSize: CGSize {
        return CGSize(width: UIView.noIntrinsicMetric, height: 28)
    }
```

Intrinsic content size is the default size a control gives itself that autolayout uses when doing autolayout. No all controls have intrinsic content size. But many do.

<img src="https://github.com/jrasmusson/ios-starter-kit/blob/master/autolayout/images/intrinsicContentSize/ios-controls.png" />

And it's an important topic if you want to understand how autolayout works with certain view configurations. It also overlaps a lot with content hugging and resistance (CHCR). So you often see them spoken about at the same time.

But here are some examples on how to use.

## Example

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

<img src="https://github.com/jrasmusson/ios-starter-kit/blob/master/autolayout/images/intrinsic.png"  />

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

That's what we use to suggest the size of our custom view but not constrain it. The super view does the constraining. The custom the suggesting. And this becomes really important in `UIStackView` because some distributions ignore the intrinsic size (fillEqually) while others use it. And ones like `fillEqually` use it for a suggestion, but you control it with Content Hugging Priority (CHP).

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

## How can I use in autolayout? Invalidate

You can style or size your `UIView`s with intrinsic content size and then invalidate the size to force a redraw on the next autolayout pass.

For example say you want to adjust the size of a custom `UIView` depending on whether a button is present.

<img src="https://github.com/jrasmusson/ios-starter-kit/blob/master/autolayout/images/intrinsicContentSize/invalidate.png" width="400"  />

Simply define your content size.

```swift
    override public var intrinsicContentSize: CGSize {
        let height: CGFloat = performPaymentExtensionButton.isHidden ? 110 : 130
        return CGSize(width: UIView.noIntrinsicMetric, height: height)
    }
```

And then invalidate it when the proper external event occurs. This will cause the view to refresh itself.

```swift
    var billing: BillingOverview? {
        didSet {
            if account.isDelinquent {
                performPaymentExtensionButton.isHidden = false
            } else {
                performPaymentExtensionButton.isHidden = true
            }

            invalidateIntrinsicContentSize() // important!
        }
    }
```


### Links that help

* [Apple Docs - Intrinsic Content Size](https://developer.apple.com/documentation/uikit/uiview/1622600-intrinsiccontentsize)
* [Apple Docs - Invalidate Content Size](https://developer.apple.com/documentation/uikit/uiview/1622457-invalidateintrinsiccontentsize)
* [Apple Docs - Views with intrinsic content size](https://developer.apple.com/library/archive/documentation/UserExperience/Conceptual/AutolayoutPG/ViewswithIntrinsicContentSize.html)
* [Apple Docs - Intrinsic Content Size Equations](https://developer.apple.com/library/archive/documentation/UserExperience/Conceptual/AutolayoutPG/AnatomyofaConstraint.html#//apple_ref/doc/uid/TP40010853-CH9-SW21)
* [Example1](https://medium.com/@vialyx/import-uikit-what-is-intrinsic-content-size-20ae302f21f3)
* [Example2](https://blog.usejournal.com/custom-uiview-in-swift-done-right-ddfe2c3080a)
* [Example3](https://samwize.com/2017/11/01/guide-to-creating-custom-uiview/)
