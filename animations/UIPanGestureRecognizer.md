# UIPanGestureRecognizer

```swift
//
//  ViewController.swift
//  UIPangesture
//
//  Created by Jonathan Rasmusson (Contractor) on 2019-07-17.
//  Copyright © 2019 Jonathan Rasmusson. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var myView = UIView()
    var animator = UIViewPropertyAnimator()

    lazy var panRecognizer: UIPanGestureRecognizer = {
        let recognizer = UIPanGestureRecognizer()
        recognizer.addTarget(self, action: #selector(handlePan(recognizer:)))
        return recognizer
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        layout()
        myView.addGestureRecognizer(panRecognizer)
    }

    func layout() {
        myView = makeView()
        view.addSubview(myView)

        myView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        myView.widthAnchor.constraint(equalToConstant: 100).isActive = true
        myView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        myView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
    }

    func makeView() -> UIView {
        let myView = UIView()
        myView.translatesAutoresizingMaskIntoConstraints = false
        myView.backgroundColor = .blue

        return myView
    }

    @objc private func handlePan(recognizer: UIPanGestureRecognizer) {
        switch recognizer.state {
        case .began:
            animator = UIViewPropertyAnimator(duration: 3, curve: .easeOut, animations: {
                self.myView.transform = CGAffineTransform(translationX: 275, y: 0)
                self.myView.alpha = 0
            })
            animator.startAnimation()
            animator.pauseAnimation()
        case .changed:
            animator.fractionComplete = recognizer.translation(in: myView).x / 275
        case .ended:
            animator.continueAnimation(withTimingParameters: nil, durationFactor: 0)
        default:
            ()
        }
    }
}
```

![TableView](https://github.com/jrasmusson/ios-starter-kit/blob/master/animations/images/pangesture.gif)


### Links that help
* [Nathan Glitter](http://www.swiftkickmobile.com/building-better-app-animations-swift-uiviewpropertyanimator/)
