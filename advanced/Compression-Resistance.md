```swift
label.setContentHuggingPriority(UILayoutPriority.defaultHigh, for: .horizontal)
label.setContentHuggingPriority(UILayoutPriority(rawValue: 250), for: .vertical)
label.setContentCompressionResistancePriority(UILayoutPriority.defaultLow, for: .horizontal)
```

# Content-Hugging Compression-Resistance (CHCR)

* Settings that describe how controls shrink and grow
* Used to break ambiguous layouts
* See a lot when layout out labels and text fields
	* Interface building sets defaults for you
* See a lot in `UILabel`s `UITextField`s `UIStackView`s and `UIImageView`s 

## Example

Here is an example showing how the label on the left is configured to expand (low hugging) while the label on the right is configured to hug (not stretch). These same principles apple to controls when inside a `UIStackView` and also `UIImageView` for when they expand. By setting hugging low, they can stretch.

<img src="https://github.com/jrasmusson/ios-starter-kit/blob/master/advanced/images/two-labels-hugging.png" alt="drawing" />


```swift
import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    func setupViews() {
        let item1 = makeLabel(title: "Internet", color: .red)       // hug = 48 => stretch
        let item2 = makeTextField(title: "Ready", color: .green)    // hug = 251
        
        view.addSubview(item1)
        view.addSubview(item2)
        
        item1.topAnchor.constraint(equalTo: view.topAnchor, constant: 48).isActive = true
        item1.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8).isActive = true
        item1.trailingAnchor.constraint(equalTo: item2.leadingAnchor, constant: 8).isActive = true
        item2.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8).isActive = true
        item1.centerYAnchor.constraint(equalTo: item2.centerYAnchor).isActive = true
    }

    func makeLabel(title: String, color: UIColor) -> UILabel {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = title
        label.textAlignment = .center
        label.textColor = .black
        label.numberOfLines = 0
        label.backgroundColor = color
        
        label.setContentHuggingPriority(UILayoutPriority(rawValue: 48), for: .horizontal)
        label.setContentHuggingPriority(UILayoutPriority(rawValue: 250), for: .vertical)

        return label
    }

    func makeTextField(title: String, color: UIColor) -> UITextField {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.text = title
        textField.backgroundColor = color

        // default IB
        textField.setContentHuggingPriority(UILayoutPriority(rawValue: 251), for: .horizontal)
        textField.setContentHuggingPriority(UILayoutPriority(rawValue: 250), for: .vertical)
        
        return textField
    }

    func makeStackView() -> UIStackView {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.alignment = .fill
        stackView.spacing = 8.0
        
        return stackView
    }

}
```




### Links that help

* [Stack Overflow](https://stackoverflow.com/questions/15850417/cocoa-autolayout-content-hugging-vs-content-compression-resistance-priority)
* [How relates to intrinsic content size](https://developer.apple.com/library/archive/documentation/UserExperience/Conceptual/AutolayoutPG/AnatomyofaConstraint.html#//apple_ref/doc/uid/TP40010853-CH9-SW21)
