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

        return label
    }()
```

## How to limit label size to on row and grow and shrink as required

Make the label single line. Pin it to leading trailing.  They set `adjustsFontSizeToFitWidth` and `minimumScaleFactor`.

```swift
    func makeOverdueAlertLabel() -> UILabel {
        let label = ControlFactory.makeBoldLabel(text: loc("Your account is overdue by $XXX"), size: 16)

        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textAlignment = .left
        label.numberOfLines = 1
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.0 // default is 0.0 so this is optional

        return label
    }
```

```swift
label.centerYAnchor.constraint(equalTo: imageView.centerYAnchor).isActive = true
label.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: LocalSpacing.betweenImageAndLabel).isActive = true
label.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8).isActive = true
```
<img src="https://github.com/jrasmusson/ios-starter-kit/blob/master/basics/UILabel/images/label-fontwidth.png" alt="drawing" width="400"/>
