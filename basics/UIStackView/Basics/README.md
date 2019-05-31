# UIStackView

## How to layout margins set insets

```swift
        let textLabelStackView = makeStackView()
        stackView.layoutMargins = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        stackView.isLayoutMarginsRelativeArrangement = true
```

or 

```swift
        stackView.layoutMargins.top = LocalSpacing.rowSpacing
        stackView.layoutMargins.left = Spacing.margin
        stackView.layoutMargins.right = Spacing.margin
```

## How to put a button in a`UIStackView`

<img src="https://github.com/jrasmusson/ios-starter-kit/blob/master/basics/UIStackView/Basics/images/button-in-a-view.png" alt="drawing" width="400"/>

The trick to getting any view to layout customer in a `UIStackView` is to embed it in a container view and then let the stackview lay it out. Meanwhile you can setup whatever padding or constraints you want between your innerview and the container view.

```swift
    let moreButton = makeMoreButton()

    let container = UIView()
    container.translatesAutoresizingMaskIntoConstraints = false
    container.heightAnchor.constraint(equalToConstant: layout.CTAButtonHeight).isActive = true
    container.addSubview(moreButton)

    moreButton.centerXAnchor.constraint(equalTo: container.centerXAnchor).isActive = true
    moreButton.centerYAnchor.constraint(equalTo: container.centerYAnchor).isActive = true
    moreButton.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 24).isActive = true
    moreButton.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -24).isActive = true
    moreButton.heightAnchor.constraint(equalToConstant: layout.CTAButtonHeight).isActive = true

    stackView.addArrangedSubview(container)
```

## How to add a separator into a `UIStackView`

Using the same technique as above, you need to add the separator into a container view, and then set contraints between the separator and container view to give it the spacing you want.

<img src="https://github.com/jrasmusson/ios-starter-kit/blob/master/basics/UIStackView/Basics/images/separator-view.png" alt="drawing" width="400"/>

```swift
    func setupViews() {
        ...
        stackView.addArrangedSubview(makeTopSeparatorView())
        ...
    }

    func makeTopSeparatorView() -> UIView {
        let container = UIView()
        container.translatesAutoresizingMaskIntoConstraints = false

        let separatorView = makeSeparatorView()

        container.addSubview(separatorView)

        separatorView.topAnchor.constraint(equalTo: container.topAnchor, constant: -12).isActive = true
        separatorView.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 24).isActive = true
        separatorView.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: 0).isActive = true

        container.heightAnchor.constraint(equalTo: separatorView.heightAnchor).isActive = true

        return container
    }
    
    func makeSeparatorView() -> UIView {
       let view = UIView()
       view.translatesAutoresizingMaskIntoConstraints = false
       view.backgroundColor = .lightGray
       view.heightAnchor.constraint(equalToConstant: 0.5).isActive = true

       return view
    }
```

# UIStackView Basics

Let's say we want to build this model using a `UIStackView`.

<img src="https://github.com/jrasmusson/ios-starter-kit/blob/master/basics/UIStackView/Basics/images/model.png" alt="drawing" width="400"/>

We can start off with a `UILabel` and `UITextField` side-by-side. 

<img src="https://github.com/jrasmusson/ios-starter-kit/blob/master/basics/UIStackView/Basics/images/no-hugging.png" alt="drawing" width="400"/>

But what we are missing is the hugging and compression necessary to tell autolayout which control to expand, and which not to.

<img src="https://github.com/jrasmusson/ios-starter-kit/blob/master/basics/UIStackView/Basics/images/chart.png" alt="drawing" width="600"/>

    Usually in this situation we want the label to hold it's intrinsic width, 
    and have the text field expand. 
    So we **increase** the `UILabel` horizontal and vertical **hugging**,
    while **decreasing** the `UITextField` hugging and horizontal resistance.

<img src="https://github.com/jrasmusson/ios-starter-kit/blob/master/basics/UIStackView/Basics/images/hugging-added.png" alt="drawing" width="400"/>

OK not bad. But what we need are some attributes on our stack views.

<img src="https://github.com/jrasmusson/ios-starter-kit/blob/master/basics/UIStackView/Basics/images/attributes.png" alt="drawing" width="600"/>

If we add those we get this

<img src="https://github.com/jrasmusson/ios-starter-kit/blob/master/basics/UIStackView/Basics/images/attributes-added.png" alt="drawing" width="400"/>

Now, if we want to add more label and text fields, and make it so everything is aligned, the trick is to make the widths of the various text fields the same. 

If we add more stack views, and don't make the text field widths the same we get this.

<img src="https://github.com/jrasmusson/ios-starter-kit/blob/master/basics/UIStackView/Basics/images/no-weight.png" alt="drawing" width="400"/>

When we add the weighting constraints (#6, #7) from diagram at top, we get this.

<img src="https://github.com/jrasmusson/ios-starter-kit/blob/master/basics/UIStackView/Basics/images/equal-weight.png" alt="drawing" width="400"/>

> Note: Order here matters. You can only add a constraint between two separate elements like this in different stack views after they have been added to the common parent. Else you will get a 'not common ancestor' error.

```swift
//
//  ViewController.swift
//  StackViewBasic
//
//  Created by Jonathan Rasmusson (Contractor) on 2018-09-05.
//  Copyright © 2018 Jonathan Rasmusson (Contractor). All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()
    }

    func setupViews () {

        // first name
        let firstNameStack = makeNameStackView()
        let firstNameLabel = makeLabel(withText: "First")
        let firstNameTextField = makeTextField(withPlaceholderText: "Enter first name")

        firstNameStack.addArrangedSubview(firstNameLabel)
        firstNameStack.addArrangedSubview(firstNameTextField)

        firstNameLabel.setContentHuggingPriority(UILayoutPriority(rawValue: 251), for: .vertical)
        firstNameLabel.setContentHuggingPriority(UILayoutPriority(rawValue: 251), for: .horizontal)

        firstNameTextField.setContentHuggingPriority(UILayoutPriority(rawValue: 48), for: .horizontal)
        firstNameTextField.setContentCompressionResistancePriority(UILayoutPriority(rawValue: 749), for: .horizontal)

        // middle name
        let middleNameStack = makeNameStackView()
        let middleNameLabel = makeLabel(withText: "Middle")
        let middleNameTextField = makeTextField(withPlaceholderText: "Enter middle name")

        middleNameStack.addArrangedSubview(middleNameLabel)
        middleNameStack.addArrangedSubview(middleNameTextField)

        middleNameLabel.setContentHuggingPriority(UILayoutPriority(rawValue: 251), for: .vertical)
        middleNameLabel.setContentHuggingPriority(UILayoutPriority(rawValue: 251), for: .horizontal)

        middleNameTextField.setContentHuggingPriority(UILayoutPriority(rawValue: 48), for: .horizontal);
        middleNameTextField.setContentCompressionResistancePriority(UILayoutPriority(rawValue: 749), for: .horizontal)

        // Name rows stack
        let nameRowsStack = makeRowStackView()

        nameRowsStack.addArrangedSubview(firstNameStack)
        nameRowsStack.addArrangedSubview(middleNameStack)

        // make the rows equal width (order matters - must come after both added to parent stack)
        firstNameTextField.widthAnchor.constraint(equalTo: middleNameTextField.widthAnchor).isActive = true

        view.addSubview(nameRowsStack)

        NSLayoutConstraint.activate([
            nameRowsStack.topAnchor.constraint(equalTo: view.topAnchor, constant: 20),
            nameRowsStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            nameRowsStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            ])

    }

    func makeNameStackView() -> UIStackView {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.distribution = .fill
        stack.alignment = .firstBaseline
        stack.spacing = 8.0

        return stack
    }

    func makeRowStackView() -> UIStackView {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.distribution = .fill
        stack.alignment = .fill
        stack.spacing = 8.0

        return stack
    }

    func makeLabel(withText text: String) -> UILabel {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = text
        label.backgroundColor = .red

        return label
    }

    func makeTextField(withPlaceholderText text: String) -> UITextField {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = text
        textField.backgroundColor = .green

        return textField
    }
}
```

### What if you are working with images?

Images in stack views have there own instrinsic views. So their height and width may not align. 

In this case you can get your images to align by changing you stack view alignment to `center`.

```swift
func makeNameStackView() -> UIStackView {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.distribution = .fill
        stack.alignment = .center // gets them aligned
        stack.spacing = 8.0

        return stack
    }
```

And then making the images themselves `scaleAspectFit`

```swift
// first name
let firstNameStack = makeNameStackView()
let chat = UIImageView(image: UIImage(named: "chat"))
chat.contentMode = .scaleAspectFit // so they don't stretch
```

If you do that, everything should line up nicely like this.

<img src="https://github.com/jrasmusson/ios-starter-kit/blob/master/basics/UIStackView/Basics/images/images.png" alt="drawing" width="400"/>

## Misc

### How to layout stackviews with different margins and padding

Say you want to layout a view like this. With the top image expandable and flush, but with other elements aligned differently with different margins. The way to do it is to insert the second element in another StackView and set is insets there.

<img src="https://github.com/jrasmusson/ios-starter-kit/blob/master/basics/UIStackView/images/stackview-different-insets.png" alt="drawing" width="400"/>


```swift
class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }

    func setupViews() {
        view.backgroundColor = .white
        title = "Connect"

        // Scroll view, vertical
        let scrollView = UIScrollView()
        view.addSubview(scrollView)

        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        scrollView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: 0).isActive = true

        // Holding a stackview
        let rootStackView = makeStackView()
        scrollView.addSubview(rootStackView)

        rootStackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor).isActive = true
        rootStackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor).isActive = true
        rootStackView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        rootStackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
        rootStackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true

        // TextLabel - Create another stackView here and set it's insets
        let textLabelStackView = makeStackView()
        textLabelStackView.layoutMargins = UIEdgeInsets(top: 0, left: 24, bottom: 0, right: 24)
        textLabelStackView.isLayoutMarginsRelativeArrangement = true

        let textLabel = makeGrayTextLabel(text: "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s.")
        textLabelStackView.addArrangedSubview(textLabel)

        rootStackView.addArrangedSubview(textLabelStackView)
    }
```
### Hugging example image, labels, image

<img src="https://github.com/jrasmusson/ios-starter-kit/blob/master/basics/UIStackView/images/image-labels-image.png" alt="drawing" width="400"/>

This examples shows how the labels in a `UIStackView` can stretch to fill available space.

```swift

    func makeDownloadLabelsStackView() -> UIView {
        let stackView = makeStackView(axis: .vertical)

        stackView.addArrangedSubview(makeDownloadTitleLabel())
        stackView.addArrangedSubview(makeDownloadSubTitleLabel())

        return stackView
    }
    
    func makeDownloadTitleLabel() -> UILabel {
        ...
        label.backgroundColor = .red
        label.setContentHuggingPriority(UILayoutPriority(rawValue: 48), for: .horizontal) // stretch horizontal
        label.setContentHuggingPriority(UILayoutPriority(rawValue: 249), for: .vertical)  // stretch vertical

        return label
    }
    
    func makeDownloadSubTitleLabel() -> UILabel {
        ...
        label.backgroundColor = .green
        label.setContentHuggingPriority(UILayoutPriority(rawValue: 48), for: .horizontal) // stretch

        return label
    }

```



### Links that help

* [Apple docs](https://developer.apple.com/documentation/uikit/uistackview)
* [Apple Example](https://developer.apple.com/library/archive/documentation/UserExperience/Conceptual/AutolayoutPG/LayoutUsingStackViews.html#//apple_ref/doc/uid/TP40010853-CH11-SW1)
* [Excellent article on distribution](https://spin.atomicobject.com/2016/06/22/uistackview-distribution/)


