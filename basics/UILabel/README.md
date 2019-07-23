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

> `minimumScaleFactor` The minimum scale factor supported for the label’s text.

The `minimumScaleFactor` is a multiplier against the label. Whatever value you choose here, is the smallest your label will become. So if you `UIFont` size is 10, and you give a `miniumScaleFactor = 0.5` the smallest your font will go is `5`. The default is '0' so you don't really need it. But it's a way for you to limit a minium font size if you want to.


<img src="https://github.com/jrasmusson/ios-starter-kit/blob/master/basics/UILabel/images/label-fontwidth.png" alt="drawing" width="400"/>
