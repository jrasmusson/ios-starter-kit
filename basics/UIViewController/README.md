# UIViewController

## How to present modally 

<img src="https://github.com/jrasmusson/ios-starter-kit/blob/master/basics/UIViewController/images/modal.png" alt="drawing" width="400"/>

- To present modally you want to use the `present` method.
- Don't `present` in `viewDidLoad()`. View hierarchy has not been loaded yet.
- Instead do it in `viewDidAppear()`. View hierarchy has been established.

```swift
class ContainerViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .red
    }
}

class LaunchViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .blue
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        let containerViewController = ContainerViewController() 

        // modal
        present(containerViewController, animated: true)
    }

}
```

> Note: This will present the viewController modally (as of iOS13). To present as full screen take over you need to `addChild`.


## How to present full screen

<img src="https://github.com/jrasmusson/ios-starter-kit/blob/master/basics/UIViewController/images/fullscreen.png" alt="drawing" width="400"/>

```swift
override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)

    let containerViewController = ContainerViewController()

    // full screen
    // The x3 things we need to do when presented a child view controller within a parent
    view.addSubview(containerViewController.view)
    addChild(containerViewController)
    containerViewController.didMove(toParent: self)
}
```

## Add/Remove Extension

```swift
extension UIViewController {
    func add(_ child: UIViewController) {
        addChild(child)
        view.addSubview(child.view)
        child.didMove(toParent: self)
    }

    func remove() {
        guard parent != nil else {
            return
        }

        willMove(toParent: nil)
        view.removeFromSuperview()
        removeFromParent()
    }
}
```

## Dismissing

`UINavigationController`s have push/pop. `UIViewControllers` have present/dismiss. 

```swift
present(viewController, animated: true)
dismiss(animated: true)
```

When you go to dismiss a presented viewController, you have three options.

### Dismiss entire stack

```swift
dismiss(animated: true)
```

This will dismiss the presented viewController, and the entire stack of viewControllers sitting on top of it.

### Dismiss only presented

```swift
presentingViewController?.dismiss(animated: true)
```

Calling this will dismiss just the currently preseted viewController.

### Dismiss via protocol delegate

You can have the parent take responsibilty for dismissing the child via protocol delegate.

```swift
import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }

    func setupViews() {
        view.backgroundColor = .red
        let button = makeButton(title: "Go to Next")
        button.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)

        view.addSubview(button)

        view.centerXAnchor.constraint(equalTo: button.centerXAnchor).isActive = true
        view.centerYAnchor.constraint(equalTo: button.centerYAnchor).isActive = true
    }

    @objc func buttonPressed() {
        let vc2 = ViewController2()
        vc2.delegate = self
        present(vc2, animated: true, completion: nil)
    }

}

extension UIViewController {

    func makeButton(title: String) -> UIButton {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle(title, for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.contentEdgeInsets = UIEdgeInsets.init(top: 8, left: 16, bottom: 8, right: 16)

        return button
    }

}

extension ViewController: ViewController2Delegate {
    func button2Pressed() {
        presentedViewController?.dismiss(animated: true)
    }
}
```

And child

```swift
import UIKit

protocol ViewController2Delegate: AnyObject {
    func button2Pressed()
}

class ViewController2: UIViewController {

    weak var delegate: ViewController2Delegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }

    func setupViews() {
        view.backgroundColor = .blue
        let button = makeButton(title: "Go back")
        button.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)

        view.addSubview(button)

        view.centerXAnchor.constraint(equalTo: button.centerXAnchor).isActive = true
        view.centerYAnchor.constraint(equalTo: button.centerYAnchor).isActive = true
    }

    @objc func buttonPressed() {
        delegate?.button2Pressed()
//        dismiss(animated: true)
//        presentingViewController?.dismiss(animated: true)
    }

}
```

## Alternative way to load a view

Often we create and layout our view in `viewDidLoad`. But there is another way this can be done.

```swift
public class PhoneTileViewController: UIViewController {
    
    let phoneTileView = PhoneTileView(frame: .zero)

    override public func loadView() {
        view = phoneTileView
    }

    public func update(with state: PhoneTileViewState) {
        phoneTileView.update(with: state)
    }
}
```

`loadView()` is method `UIViewController` calls when it loads its view. `viewDidLoad` is a bit of lie. When we call it, we _expect_ our view to already be loaded! But for reasons (mostly convention) we don't. We instead usually do most of our layout in there because that's what everyone else does.

When you call

```swift
    override public func loadView() {
        view = phoneTileView
    }
```

The view gets layed out according to however that _ViewController_ gets presented. If it is presented modally from a rootViewController in a _NavigationController_ it will fill the entire screen frame.

If it is embedded as a subsubview somewhere else it will view whatever space it is given.

## How to add a linear gradient view to the background of every view controller

```swift
public extension UIViewController {
func insertGradientBackground() {
        let background = LinearGradientView()
        background.translatesAutoresizingMaskIntoConstraints = false
        
        view.insertSubview(background, at: 0)

        NSLayoutConstraint.activate(background.makeEdgeConstraints(equalToAnchorsOf: view))
    }
}

open class LinearGradientView: UIView {

    @objc let leftColor: UIColor = UIColor.Rebrand.quinary_accent()
    @objc let rightColor: UIColor = UIColor.Rebrand.primary()
    @objc let gradientLayer = CAGradientLayer()

    override public init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }

    private func commonInit() {
        gradientLayer.colors = [leftColor.cgColor, rightColor.cgColor]
        gradientLayer.transform = CATransform3DMakeRotation(CGFloat.pi / 2, 0, 0, 1)
        layer.addSublayer(gradientLayer)
    }

    override open func layoutSubviews() {
        super.layoutSubviews()

        if gradientLayer.frame != bounds {
            gradientLayer.frame = bounds
        }
    }
}
```

### Links that help

- [Push & Pop](https://medium.com/@felicity.johnson.mail/pushing-popping-dismissing-viewcontrollers-a30e98731df5)
- [Use your loaf](https://useyourloaf.com/blog/presenting-view-controllers/)
- [Sundell How to add child viewController](https://www.swiftbysundell.com/articles/using-child-view-controllers-as-plugins-in-swift/)
