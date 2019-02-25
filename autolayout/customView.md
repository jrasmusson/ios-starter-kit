# Custom Views

Here are some things you need to know about creating custom views in iOS.

* don't set width/height constraints in custom views
* just do your layout relative to the bounds of the view you are in, but let the container control how you appear in the super view via it's contraints and let it set the hugging and compressing
* do give your views an intrinsic size if you can. This will help them with various autolayout configurations and get rid of ambiguous layout. It will also help with `UIStackView`

Let's look at some examples.

## Basic custom view

<img src="https://github.com/jrasmusson/ios-starter-kit/blob/master/autolayout/images/customview/basic2.png" alt="drawing" width="400"/>

Here is a customer view, laid out in the view controller beside a `UILabel`. Note how the `UIView` defines its own intrinsic content size. Hense we don't need any width height constraints as both the label and view have their sizes defined.

```swift
import UIKit

public class ReadyToActivateView: UIView {

    let dotRadius: CGFloat = 4

    struct Spacing {
        static let marginSmall = CGFloat(4)
    }

    public override init(frame: CGRect) {
        super.init(frame: frame)

        let orangeDot = makeOrangeDot()
        let label = makeLabel()

        addSubview(orangeDot)
        addSubview(label)

        orangeDot.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        orangeDot.widthAnchor.constraint(equalToConstant: dotRadius*2).isActive = true
        orangeDot.heightAnchor.constraint(equalToConstant: dotRadius*2).isActive = true
        orangeDot.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: Spacing.marginSmall).isActive = true

        label.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        label.leadingAnchor.constraint(equalTo: orangeDot.trailingAnchor, constant: Spacing.marginSmall*2).isActive = true
        label.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -Spacing.marginSmall).isActive = true
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override public var intrinsicContentSize: CGSize {
        return CGSize(width: 110, height: 28)
    }

    // MARK: - Factory methods

    func makeOrangeDot() -> UIView {
        let view = UIView.init(frame: CGRect(x: 0, y: 0, width: dotRadius*2, height: dotRadius*2))
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.borderColor = UIColor.orange.cgColor
        view.layer.backgroundColor = UIColor.orange.cgColor
        view.layer.cornerRadius = dotRadius
        view.layer.borderWidth = 0.5

        return view
    }

    func makeLabel() -> UILabel {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.textColor = .darkGray
        label.font = UIFont.systemFont(ofSize: 8)
        label.numberOfLines = 0
        label.text = "Ready to activate"

        return label
    }

}
```

```swift
class BasicViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }

    func setupViews() {
        view.backgroundColor = .white
        
        let item1 = makeLabel(title: "Internet")
        let item2 = makeCustomView()

        view.addSubview(item1)
        view.addSubview(item2)

        item1.topAnchor.constraint(equalTo: view.topAnchor, constant: 48).isActive = true
        item1.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8).isActive = true
        item1.trailingAnchor.constraint(equalTo: item2.leadingAnchor, constant: -8).isActive = true
        item2.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8).isActive = true
        item1.centerYAnchor.constraint(equalTo: item2.centerYAnchor).isActive = true    }

    func makeLabel(title: String) -> UILabel {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = title
        label.textAlignment = .center
        label.textColor = .black
        label.numberOfLines = 0
        label.backgroundColor = .red

        return label
    }

    func makeCustomView() -> UIView {
        let view = ReadyToActivateView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .green

        return view
    }

}
```

### Links that help

* [Apple Docs - Intrinsic Content Size](https://developer.apple.com/documentation/uikit/uiview/1622600-intrinsiccontentsize)
* [Apple Docs - Views with intrinsic content size](https://developer.apple.com/library/archive/documentation/UserExperience/Conceptual/AutolayoutPG/ViewswithIntrinsicContentSize.html)
* [Apple Docs - Intrinsic Content Size Equations](https://developer.apple.com/library/archive/documentation/UserExperience/Conceptual/AutolayoutPG/AnatomyofaConstraint.html#//apple_ref/doc/uid/TP40010853-CH9-SW21)
* [What is tntrinsic content size](https://medium.com/@vialyx/import-uikit-what-is-intrinsic-content-size-20ae302f21f3)
* [Custom view in swift done right](https://blog.usejournal.com/custom-uiview-in-swift-done-right-ddfe2c3080a)
* [Guide to creating custom uiview](https://samwize.com/2017/11/01/guide-to-creating-custom-uiview/)
