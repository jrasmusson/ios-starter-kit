# Interactive Animations

![TableView](https://github.com/jrasmusson/ios-starter-kit/blob/master/animations/images/demo-InteractiveAnimations.gif)

There is a lot going on in this demo. Read Nathan's blog post for a detailed break down. But basically we are creating a view, animating it's display up using `UIViewPropertyAnimator` and then taking into account a whole bunch of things like

- direction
- reveribility
- fraction complete
- custom tap gesture to act more like a scroll

* [Nathan Glitter](http://www.swiftkickmobile.com/building-better-app-animations-swift-uiviewpropertyanimator/)

```swift
//
//  ViewController.swift
//  InteractiveAnimations
//
//  Created by Nathan Gitter on 9/4/17.
//  Copyright © 2017 Nathan Gitter. All rights reserved.
//

import UIKit
import UIKit.UIGestureRecognizerSubclass

private enum State {
    case closed
    case open
}

extension State {
    var opposite: State {
        switch self {
        case .open: return .closed
        case .closed: return .open
        }
    }
}

class ViewController: UIViewController {

    private let popupOffset: CGFloat = 440

    private lazy var popupView: UIView = {
        let view = UIView()
        view.backgroundColor = .gray
        view.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner] // animate corner radius
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        layout()
        popupView.addGestureRecognizer(panRecognizer)
    }

    private var bottomConstraint = NSLayoutConstraint()

    private func layout() {
        popupView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(popupView)
        popupView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        popupView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        bottomConstraint = popupView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: popupOffset)
        bottomConstraint.isActive = true
        popupView.heightAnchor.constraint(equalToConstant: 500).isActive = true
    }

    private var currentState: State = .closed

    private var transitionAnimator = UIViewPropertyAnimator()

    private var animationProgress: CGFloat = 0

    private lazy var panRecognizer: InstantPanGestureRecognizer = {
        let recognizer = InstantPanGestureRecognizer()
        recognizer.addTarget(self, action: #selector(popupViewPanned(recognizer:)))
        return recognizer
    }()

    private func animateTransitionIfNeeded(to state: State, duration: TimeInterval) {
        if transitionAnimator.isRunning { return }

        // animate the transition
        transitionAnimator = UIViewPropertyAnimator(duration: duration, dampingRatio: 1, animations: {
            switch state {
            case .open:
                self.bottomConstraint.constant = 0
                self.popupView.layer.cornerRadius = 20
            case .closed:
                self.bottomConstraint.constant = self.popupOffset
                self.popupView.layer.cornerRadius = 0
            }
            self.view.layoutIfNeeded()
        })

        // record the current state once complete
        transitionAnimator.addCompletion { position in
            switch position {
            case .start:
                self.currentState = state.opposite
            case .end:
                self.currentState = state
            case .current:
                ()
            @unknown default:
                ()
            }

            // reset to current state in case offset was adjusted
            switch self.currentState {
            case .open:
                self.bottomConstraint.constant = 0
            case .closed:
                self.bottomConstraint.constant = self.popupOffset
            }
        }
        transitionAnimator.startAnimation()
    }

    // scrub the animation taking into account how much complete and whether to reverse based on velocity and direction
    @objc private func popupViewPanned(recognizer: UIPanGestureRecognizer) {
        switch recognizer.state {
        case .began:
            animateTransitionIfNeeded(to: currentState.opposite, duration: 1.5)
            transitionAnimator.pauseAnimation()
            animationProgress = transitionAnimator.fractionComplete
        case .changed:
            let translation = recognizer.translation(in: popupView)
            var fraction = -translation.y / popupOffset
            if currentState == .open { fraction *= -1 }
            if transitionAnimator.isReversed { fraction *= -1 }
            transitionAnimator.fractionComplete = fraction + animationProgress
        case .ended:
            let yVelocity = recognizer.velocity(in: popupView).y
            let shouldClose = yVelocity > 0
            if yVelocity == 0 {
                transitionAnimator.continueAnimation(withTimingParameters: nil, durationFactor: 0)
                break
            }
            switch currentState {
            case .open:
                if !shouldClose && !transitionAnimator.isReversed { transitionAnimator.isReversed = !transitionAnimator.isReversed }
                if shouldClose && transitionAnimator.isReversed { transitionAnimator.isReversed = !transitionAnimator.isReversed }
            case .closed:
                if shouldClose && !transitionAnimator.isReversed { transitionAnimator.isReversed = !transitionAnimator.isReversed }
                if !shouldClose && transitionAnimator.isReversed { transitionAnimator.isReversed = !transitionAnimator.isReversed }
            }
            transitionAnimator.continueAnimation(withTimingParameters: nil, durationFactor: 0)
        default:
            ()
        }
    }

}

// The interruption behavior works, but is awkward. In order for the pan to be recognized, the user must tap on the screen and then move their finger in any direction. We would prefer the behavior to act like a scroll view, which allows the user to “catch” the view with only a touch down. Currently, the tap gesture and pan gesture are only fired on touch up and touches moved, respectively. In order to fire an event on touch down, we can create our own custom gesture recognizer.

// This pan gesture subclass enters the began state on touch down. It allows us to replace both of our previous gesture recognizers. The “tap” is now an “instant pan” that ends right after it begins. By using this custom gesture recognizer, we can improve the behavior of our previous tap/pan solution as well as simplify our logic.

class InstantPanGestureRecognizer: UIPanGestureRecognizer {

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent) {
        if (self.state == UIGestureRecognizer.State.began) { return }
        super.touchesBegan(touches, with: event)
        self.state = UIGestureRecognizer.State.began
    }

}
```




### Links that help
* [Nathan Glitter](http://www.swiftkickmobile.com/building-better-app-animations-swift-uiviewpropertyanimator/)
