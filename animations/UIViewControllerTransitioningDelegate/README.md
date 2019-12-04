# UIViewControllerTransitioningDelegate

This is a delegate you can create that can do some additional processing between `UIViewController` transitions when using 'viewController.present'. 

<img src="https://github.com/jrasmusson/ios-starter-kit/blob/master/animations/UIViewControllerTransitioningDelegate/images/transition.png" alt="drawing" width="400"/>

By defining a delegate

```swift
import UIKit

class CustomTransitionDelegate: NSObject, UIViewControllerTransitioningDelegate {

    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return FadePushAnimator()
    }

    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return FadePopAnimator()
    }
}
```

And then setting it on the viewController you are transitioning too...

```swift
    @objc func buttonPressed() {
        let vc2 = ViewController2()
        vc2.transitioningDelegate = transitionDelegate
        present(vc2, animated: true, completion: nil)
    }
```

You can add animations and customize transitions from one viewController to another.

![TableView](https://github.com/jrasmusson/ios-starter-kit/blob/master/animations/UIViewControllerTransitioningDelegate/demo.gif)

### Full source

```swift
import UIKit

class ViewController1: UIViewController {

    let transitionDelegate: UIViewControllerTransitioningDelegate = CustomTransitionDelegate()

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
        vc2.transitioningDelegate = transitionDelegate
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
```

```swift
import UIKit

class ViewController2: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }

    func setupViews() {
        view.backgroundColor = .blue
        let button = makeButton(title: "Go back")
        button.addTarget(self, action: #selector(button2Pressed), for: .touchUpInside)

        view.addSubview(button)

        view.centerXAnchor.constraint(equalTo: button.centerXAnchor).isActive = true
        view.centerYAnchor.constraint(equalTo: button.centerYAnchor).isActive = true
    }

    @objc func button2Pressed() {
        dismiss(animated: true)
    }

}
```

```swift
import UIKit

class CustomTransitionDelegate: NSObject, UIViewControllerTransitioningDelegate {

    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return FadePushAnimator()
    }

    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return FadePopAnimator()
    }
}
```

```swift
import UIKit

class FadePushAnimator: NSObject, UIViewControllerAnimatedTransitioning {

    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.5
    }

    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard
            let toViewController = transitionContext.viewController(forKey: .to)
            else {
                return
        }
        transitionContext.containerView.addSubview(toViewController.view)
        toViewController.view.alpha = 0

        let duration = self.transitionDuration(using: transitionContext)
        UIView.animate(withDuration: duration, animations: {
            toViewController.view.alpha = 1
        }, completion: { _ in
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        })
    }
}
```

```swift
import UIKit

class FadePopAnimator: NSObject, UIViewControllerAnimatedTransitioning {

    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.5
    }

    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard
            let fromViewController = transitionContext.viewController(forKey: .from),
            let toViewController = transitionContext.viewController(forKey: .to)
            else {
                return
        }

        transitionContext.containerView.insertSubview(toViewController.view, belowSubview: fromViewController.view)

        let duration = self.transitionDuration(using: transitionContext)
        UIView.animate(withDuration: duration, animations: {
            fromViewController.view.alpha = 0
        }, completion: { _ in
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        })
    }
}
```


### Links that help

- [UIViewControllerTransitioningDelegate](https://developer.apple.com/documentation/uikit/uiviewcontrollertransitioningdelegate)
- [Example](https://itnext.io/learn-ios-custom-view-controller-animation-transition-once-for-all-9db80ad447e)

More Links

- [UIViewControllerAnimatedTransitioning](https://developer.apple.com/documentation/uikit/uiviewcontrolleranimatedtransitioning)
- [UIViewControllerInteractiveTransitioning](https://developer.apple.com/documentation/uikit/uiviewcontrollerinteractivetransitioning)
- [UIPercentDrivenInteractiveTransition](https://developer.apple.com/documentation/uikit/uipercentdriveninteractivetransition)
- [Good explaination of all transition types](https://guides.codepath.com/ios/View-Controller-Transitions)
