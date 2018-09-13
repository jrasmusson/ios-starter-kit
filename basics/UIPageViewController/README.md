# UIPageViewController

`UIPageViewController` consists of a main content page, followed by a series of `UIViewController`s you stick inside it.

[Demo](https://github.com/jrasmusson/ios-starter-kit/blob/master/basics/UIPageViewController/images/demo.gif)

```swift
//
//  ViewController.swift
//  UIPageViewContoller
//
//  Created by Jonathan Rasmusson (Contractor) on 2018-09-13.
//  Copyright © 2018 Jonathan Rasmusson (Contractor). All rights reserved.
//

import UIKit

class ViewController1: UIViewController {

    let billImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = .red

        return imageView
    }()

    let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Title1"
        label.font = UIFont.boldSystemFont(ofSize: 28)
        label.textAlignment = .center
        label.textColor = UIColor(red:0.2, green:0.26, blue:0.31, alpha:1)

        return label
    }()

    let bodyLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec sit amet placerat elit. Fusce dictum arcu in velit rutrum maximus at nec sapien. Maecenas a enim nisl."
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = UIColor.gray

        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()
        view.backgroundColor = UIColor.white
    }

    func setupViews() {
        view.addSubview(billImageView)

        let containerStack = makeContainerStackView()
        containerStack.addArrangedSubview(titleLabel)
        containerStack.addArrangedSubview(bodyLabel)

        view.addSubview(containerStack)

        if #available(iOS 11, *) {
            billImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 60).isActive = true
        } else {
            billImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 60).isActive = true
        }

        billImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        billImageView.heightAnchor.constraint(equalToConstant: 250).isActive = true
        billImageView.widthAnchor.constraint(equalToConstant: 250).isActive = true

        containerStack.topAnchor.constraint(equalTo: billImageView.bottomAnchor, constant: 24).isActive = true
        containerStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24).isActive = true
        containerStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24).isActive = true
    }

    func makeLabel() -> UILabel {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.font = UIFont.systemFont(ofSize: 13)
        label.textColor = UIColor(red: 0.4, green: 0.4, blue: 0.4, alpha: 1)

        return label
    }

    func makeContainerStackView() -> UIStackView {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.distribution = .fill
        stack.alignment = .fill
        stack.spacing = 16.0

        return stack
    }


}
```

```
//
//  ViewController.swift
//  UIPageViewContoller
//
//  Created by Jonathan Rasmusson (Contractor) on 2018-09-13.
//  Copyright © 2018 Jonathan Rasmusson (Contractor). All rights reserved.
//

import UIKit

class ViewController1: UIViewController {

    let billImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = .red

        return imageView
    }()

    let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Title1"
        label.font = UIFont.boldSystemFont(ofSize: 28)
        label.textAlignment = .center
        label.textColor = UIColor(red:0.2, green:0.26, blue:0.31, alpha:1)

        return label
    }()

    let bodyLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec sit amet placerat elit. Fusce dictum arcu in velit rutrum maximus at nec sapien. Maecenas a enim nisl."
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = UIColor.gray

        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()
        view.backgroundColor = UIColor.white
    }

    func setupViews() {
        view.addSubview(billImageView)

        let containerStack = makeContainerStackView()
        containerStack.addArrangedSubview(titleLabel)
        containerStack.addArrangedSubview(bodyLabel)

        view.addSubview(containerStack)

        if #available(iOS 11, *) {
            billImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 60).isActive = true
        } else {
            billImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 60).isActive = true
        }

        billImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        billImageView.heightAnchor.constraint(equalToConstant: 250).isActive = true
        billImageView.widthAnchor.constraint(equalToConstant: 250).isActive = true

        containerStack.topAnchor.constraint(equalTo: billImageView.bottomAnchor, constant: 24).isActive = true
        containerStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24).isActive = true
        containerStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24).isActive = true
    }

    func makeLabel() -> UILabel {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.font = UIFont.systemFont(ofSize: 13)
        label.textColor = UIColor(red: 0.4, green: 0.4, blue: 0.4, alpha: 1)

        return label
    }

    func makeContainerStackView() -> UIStackView {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.distribution = .fill
        stack.alignment = .fill
        stack.spacing = 16.0

        return stack
    }


}
```

```swift
//
//  ViewController.swift
//  UIPageViewContoller
//
//  Created by Jonathan Rasmusson (Contractor) on 2018-09-13.
//  Copyright © 2018 Jonathan Rasmusson (Contractor). All rights reserved.
//

import UIKit

class ViewController2: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.red

        let labelInst = UILabel()
        self.view.addSubview(labelInst)
        labelInst.text = "Page 2"
        labelInst.translatesAutoresizingMaskIntoConstraints = false
        labelInst.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 50).isActive = true
        labelInst.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 20).isActive = true
    }

}
```

## . TransitionStyle

There are two types of transitions files. `.pageCurl` was you saw at the top. The other is `.scroll`.

```swift
window?.rootViewController = PageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
```

[Demo](https://github.com/jrasmusson/ios-starter-kit/blob/master/basics/UIPageViewController/images/scroll.gif)
