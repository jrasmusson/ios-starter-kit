# UILabel

```swift
    func makeLabel(withTitle title: String, size: CGFloat) -> UILabel {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = title
        label.textAlignment = .center
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: size)
        label.numberOfLines = 0
        label.adjustsFontSizeToFitWidth = true

        return label
    }

    let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Title"
        label.textAlignment = .center
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 13)
        label.numberOfLines = 0
        label.adjustsFontSizeToFitWidth = true        

        return label
    }()
```

## How to adjust label size when width shrinks

If your label ever gets compressed, you can make the `UILabel` dynamically adjust itself by using these two properties.

```swift
button.titleLabel?.minimumScaleFactor = 0.5 // default 0
button.titleLabel?.adjustsFontSizeToFitWidth = true // default false
```

> `adjustsFontSizeToFitWidth` A Boolean value indicating whether the font size should be reduced in order to fit the title string into the label’s bounding rectangle.

```swift
    func makeOverdueAlertLabel() -> UILabel {
        let label = ControlFactory.makeBoldLabel(text: loc("Your account is overdue by $XXX"), size: 16)

        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textAlignment = .left
        label.numberOfLines = 1
        label.adjustsFontSizeToFitWidth = true
        
        return label
    }
```

```swift
label.centerYAnchor.constraint(equalTo: imageView.centerYAnchor).isActive = true
label.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: LocalSpacing.betweenImageAndLabel).isActive = true
label.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8).isActive = true
```
<img src="https://github.com/jrasmusson/ios-starter-kit/blob/master/basics/UILabel/images/label-fontwidth.png" alt="drawing" width="400"/>
