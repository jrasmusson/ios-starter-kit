# How to TPKeyboardAvoiding

This library deals with the popping up keyboard problem by putting your view into a scrollable view. Note: It doesn't adjust labels. Only fields that can respond as first responders. So if you have a layout containing labels, it will not adjust for those. But if you have multiple textFields, it will focus on each one and adjust the scrollview insets accordingly.

There is also a `UITableViewController` and `UICollectionViewController` variant too.


![TableView](https://github.com/jrasmusson/ios-starter-kit/blob/master/howtos/images/demo-TPKeyboardAvoiding.gif)

```swift
> pod init
> pod 'TPKeyboardAvoiding', '~> 1.3'
> pod install
```

```swift
import UIKit
import TPKeyboardAvoiding

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }

    func setupViews() {
        let scrollView = makeScrollView()
        let top = makeTextField()
        let middle = makeTextField()

        view.addSubview(scrollView)

        scrollView.addSubview(top)
        scrollView.addSubview(middle)

        scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true

        top.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 8).isActive = true
        top.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 8).isActive = true

        middle.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        middle.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 500).isActive = true
    }

    func makeTextField() -> UITextField {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.text = "Password"
        textField.backgroundColor = .yellow

        return textField
    }

    func makeScrollView() -> TPKeyboardAvoidingScrollView {
        let scrollView = TPKeyboardAvoidingScrollView(frame: .zero)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.alwaysBounceVertical = true
        scrollView.showsVerticalScrollIndicator = false

        return scrollView
    }

    func makeButton(title: String) -> UIButton {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle(title, for: .normal)
        button.contentEdgeInsets = UIEdgeInsets.init(top: 8, left: 16, bottom: 8, right: 16)
        button.backgroundColor = .blue

        return button
    }
}
```


### Links

- [TPKeyboardAvoiding](https://github.com/michaeltyson/TPKeyboardAvoiding)
- [Cocoa Pod](https://cocoapods.org/pods/TPKeyboardAvoiding)
