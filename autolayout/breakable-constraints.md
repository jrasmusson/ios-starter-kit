# Breakable constraints

## Example

Say you want a view to resize itself based on whether a button is visible or not. Create a breakable constraint from the bottom of the label to the bottom, and then turn off the constraints surrounding the button when it disappears.

<img src="https://github.com/jrasmusson/ios-starter-kit/blob/master/autolayout/images/breakable-design.png" width="400"  alt="drawing" />

![TableView](https://github.com/jrasmusson/ios-starter-kit/blob/master/autolayout/images/breakable-demo.gif)


```swift
//
//  View.swift
//  Foo1
//
//  Created by Jonathan Rasmusson (Contractor) on 2019-06-14.
//  Copyright © 2019 Jonathan Rasmusson. All rights reserved.
//

import UIKit

class MyView: UIView {

    var label = UILabel()
    var button = UIButton()

    // constraints
    var buttonTopConstraint = NSLayoutConstraint()
    var buttonBottomConstraint = NSLayoutConstraint()
    var labelBottomConstraintBreakable = NSLayoutConstraint()

    override init(frame: CGRect) {
        super.init(frame: frame)

        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        backgroundColor = .red

        label = makeLabel(withTitle: "Some text", size: 16)
        button = makeButton(title: "Press")

        addSubview(label)
        addSubview(button)

        label.topAnchor.constraint(equalTo: topAnchor, constant: 8).isActive = true
        label.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8).isActive = true
        label.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8).isActive = true

        button.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        button.widthAnchor.constraint(equalToConstant: 100).isActive = true

        // flexible
        buttonTopConstraint = label.bottomAnchor.constraint(equalTo: button.topAnchor, constant: -16)
        buttonBottomConstraint = button.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8)
        labelBottomConstraintBreakable = label.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8)

        buttonTopConstraint.isActive = true
        buttonBottomConstraint.isActive = true
        labelBottomConstraintBreakable.priority = .defaultLow
        labelBottomConstraintBreakable.isActive = true
    }

    // MARK: - Actions

    func adjust() {
        button.isHidden = !button.isHidden
        buttonTopConstraint.isActive = !buttonTopConstraint.isActive
        buttonBottomConstraint.isActive = !buttonBottomConstraint.isActive
    }
}

// MARK: - Factory methods

extension UIView {

    func makeLabel(withTitle title: String, size: CGFloat) -> UILabel {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = title
        label.textAlignment = .center
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: size)
        label.numberOfLines = 0

        return label
    }

    func makeButton(title: String) -> UIButton {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle(title, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        button.backgroundColor = .white
        button.setTitleColor(.blue, for: .normal)
        button.titleLabel?.numberOfLines = 0
        button.titleLabel?.lineBreakMode = .byWordWrapping
        button.contentHorizontalAlignment = .center

        return button
    }
}
```

```swift
//
//  ViewController.swift
//  Foo1
//
//  Created by Jonathan Rasmusson (Contractor) on 2019-06-14.
//  Copyright © 2019 Jonathan Rasmusson. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var myView = MyView()
    var adjustButton = UIButton()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }

    func setupViews() {
        myView = makeMyView()
        adjustButton = makeButton(title: "Adjust")

        view.addSubview(myView)
        view.addSubview(adjustButton)

        myView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8).isActive = true
        myView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8).isActive = true
        myView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8).isActive = true
        // bottom not required

        adjustButton.topAnchor.constraint(equalTo: myView.bottomAnchor, constant: 80).isActive = true
        adjustButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        adjustButton.widthAnchor.constraint(equalToConstant: 100).isActive = true
        // bottom not required
    }

    @objc func buttonPressed(sender: UIButton!) {
        myView.adjust()
    }
}

// MARK: - Factory methods

extension ViewController {

    func makeMyView() -> MyView {
        let view = MyView()
        view.translatesAutoresizingMaskIntoConstraints = false

        return view
    }

    func makeLabel(withTitle title: String, size: CGFloat) -> UILabel {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = title
        label.textAlignment = .center
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: size)
        label.numberOfLines = 0

        return label
    }

    func makeButton(title: String) -> UIButton {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle(title, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        button.backgroundColor = .white
        button.setTitleColor(.blue, for: .normal)
        button.titleLabel?.numberOfLines = 0
        button.titleLabel?.lineBreakMode = .byWordWrapping
        button.contentHorizontalAlignment = .center

        button.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)

        return button
    }

}
```

### No breakables required with StackView

Here is the same example only with a `UIStackView`. When you hide a view in a stackView it automatically resizes. This is one of the advantages of stackView and is why Apple pushes them so hard. They put a lot of magic in there and handle stuff like this for you.

Just remember to adjust your constraints in the `UIView` to the stackView (not the view itself). And when you hide it will change the intrinsic size of the stack to adjust to the button being hidden.

* Pin the stackView to the view so it is flush, and the tweak using edgeInsets.
* Don't set the width of the button (StackView wants to fill this out itself)

<img src="https://github.com/jrasmusson/ios-starter-kit/blob/master/autolayout/images/breakable-stackview.png" width="400"  alt="drawing" />

![TableView](https://github.com/jrasmusson/ios-starter-kit/blob/master/autolayout/images/breakable-stackview.gif)

```swift
import UIKit

class MyView: UIView {

    var label = UILabel()
    var button = UIButton()
    var stackView = UIStackView()

    override init(frame: CGRect) {
        super.init(frame: frame)

        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        label = makeLabel(withTitle: "Some text", size: 16)
        button = makeButton(title: "Press")
        stackView = makeStackView()

        stackView.addArrangedSubview(label)
        stackView.addArrangedSubview(button)

        addSubview(stackView)

        stackView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        stackView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        stackView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        stackView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true

        // bottom neccesary ? Yes else size of stackView ambiguous - it cant figure out intrinsic size itself
        // even though made up of standard controls all with instinsic sizes

        stackView.layoutMargins = UIEdgeInsets(top: 8, left: 8, bottom: -8, right: 8)
        stackView.isLayoutMarginsRelativeArrangement = true
    }

    // MARK: - Actions

    func adjust() {
        button.isHidden = !button.isHidden
    }
}
```

```swift

```


## Example in Interface Builder Xcode

Here is an example of a breakable contraint. Say you want a label to be at least 20px from the top, but flexible enough to be more if needed.

<img src="https://github.com/jrasmusson/ios-starter-kit/blob/master/autolayout/images/breakable1.png" width="400"  alt="drawing" />

You could do this by adding two constraints. One saying the spacing needs to be 20 (but give it a lower priority). And another saying spacing needs to be at least 20 or greater and make that a requirement (default priority 250 or 1000).

<img src="https://github.com/jrasmusson/ios-starter-kit/blob/master/autolayout/images/breakable2.png" width="400"  alt="drawing" />

The first constraint we call breakable because it is of a lower priority than the default and the others ones relative to it.

This technique is how minimum spacing is acheived, while providing designs enough flexibility to shrink and grow.



### Links that help
- [Apple Intrinsic Size](https://developer.apple.com/library/archive/documentation/UserExperience/Conceptual/AutolayoutPG/ViewswithIntrinsicContentSize.html)
