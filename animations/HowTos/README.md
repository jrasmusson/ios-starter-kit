# How to animations

## Bouncy button

![Demo](https://github.com/jrasmusson/ios-starter-kit/blob/master/animations/HowTos/images/bouncy-button.gif)

```swift
@objc func buttonPressed(sender: UIButton!) {
    let button = sender
    let bounds = button!.bounds

    UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.2, initialSpringVelocity: 10, options: .curveEaseInOut, animations: {
        button?.bounds = CGRect(x: bounds.origin.x - 20, y: bounds.origin.y, width: bounds.size.width + 60, height: bounds.size.height)
    }) { (success: Bool) in
        UIView.animate(withDuration: 0.5, animations: {
            button?.bounds = bounds
        })
    }
}
```

## How to animate a view in a Stack

![Demo](https://github.com/jrasmusson/ios-starter-kit/blob/master/animations/HowTos/images/simple-stack.gif)

Animating in a `UIStackView` is pretty easy. Just change the visibility, and the stackView takes care of the rest for you.

```swift
UIView.animate(withDuration: 0.8) {
    self.stackView.arrangedSubviews[1].isHidden = false
    self.label.alpha = 1
}
```

If you want a bit of bounce, add a spring. Note the extra brackets.

```swift
UIView.animate(withDuration: 0.8, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
    self.stackView.arrangedSubviews[1].isHidden = true
    self.label.alpha = 0
})
```

Here is the full source.

```swift
//
//  ViewController.swift
//  AnimationStack
//
//  Created by Jonathan Rasmusson (Contractor) on 2019-05-08.
//  Copyright © 2019 Jonathan Rasmusson. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var stackView = UIStackView()
    var label = UILabel()
    var isShown = true

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }

    func setupViews() {
        view.backgroundColor = .red

        stackView = makeStackView()

        view.addSubview(stackView)

        stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true

        stackView.addArrangedSubview(makeLabel(withTitle: "XXX", size: 20, color: .yellow))
        label = makeLabel(withTitle: "Show", size: 40, color: .green)
        stackView.addArrangedSubview(label)
        stackView.addArrangedSubview(makeLabel(withTitle: "XXX", size: 20, color: .yellow))
        stackView.addArrangedSubview(makeButton(withTitle: "Show / Hide"))
    }

    @objc func buttonPressed(sender: UIButton!) {

        if isShown {
            // Hide
            UIView.animate(withDuration: 0.8, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                self.stackView.arrangedSubviews[1].isHidden = true
                self.label.alpha = 0
            })
        } else {
            // Show
            UIView.animate(withDuration: 0.8) {
                self.stackView.arrangedSubviews[1].isHidden = false
                self.label.alpha = 1
            }
        }

        isShown = !isShown
    }

    func makeStackView() -> UIStackView {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.distribution = .fill
        stack.spacing = 8.0

        return stack
    }

    func makeLabel(withTitle title: String, size: CGFloat, color: UIColor) -> UILabel {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = title
        label.textAlignment = .center
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: size)
        label.backgroundColor = color
        label.numberOfLines = 0

        return label
    }

    func makeButton(withTitle title: String) -> UIButton {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle(title, for: .normal)
        button.titleLabel?.minimumScaleFactor = 0.5
        button.titleLabel?.font = UIFont.systemFont(ofSize: 40)
        button.titleLabel?.adjustsFontSizeToFitWidth = true
        button.backgroundColor = .blue
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 20

        button.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)

        return button
    }

}
```

### Links that help
* [Wonderlich](https://www.youtube.com/watch?time_continue=116&v=zm09jw1v19I)
