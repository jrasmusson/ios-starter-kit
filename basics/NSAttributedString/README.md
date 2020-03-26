# NSAttributedString

## Formatting with baseline

```swift
func makeAttributed2() -> UILabel {
    let dollarSignAttributes: [NSAttributedString.Key: Any] = [.font: UIFont.preferredFont(forTextStyle: .callout), .baselineOffset: 8]
    let priceAttributes: [NSAttributedString.Key: Any] = [.font: UIFont.preferredFont(forTextStyle: .title1)]
    let monthAttributes: [NSAttributedString.Key: Any] = [.font: UIFont.preferredFont(forTextStyle: .callout)]
    let termAttributes: [NSAttributedString.Key: Any] = [.font: UIFont.preferredFont(forTextStyle: .footnote), .baselineOffset: 8]

    let rootString = NSMutableAttributedString(string: "$", attributes: dollarSignAttributes)
    let priceString = NSAttributedString(string: "8", attributes: priceAttributes)
    let monthString = NSAttributedString(string: "/mo", attributes: monthAttributes)
    let termString = NSAttributedString(string: "1", attributes: termAttributes)

    rootString.append(priceString)
    rootString.append(monthString)
    rootString.append(termString)

    let label = UILabel()
    label.attributedText = rootString

    return label
}
```

<img src="https://github.com/jrasmusson/ios-starter-kit/blob/master/basics/NSAttributedString/images/baseline.png" />

## Bolding in paragraph

<img src="https://github.com/jrasmusson/ios-starter-kit/blob/master/basics/NSAttributedString/images/bold.png" width="400"/>

```swift
private func makeSubLabel() -> UILabel {
    let subLabel = UILabel()
    subLabel.textAlignment = .center
    subLabel.numberOfLines = 0
    subLabel.translatesAutoresizingMaskIntoConstraints = false

    subLabel.textColor = UIColor.shawGreyishBlack

    var plainTextAttributes = [NSAttributedString.Key: AnyObject]()
    plainTextAttributes[.font] = UIFont.preferredFont(forTextStyle: .subheadline)

    var boldTextAttributes = [NSAttributedString.Key: AnyObject]()
    boldTextAttributes[.foregroundColor] = UIColor.black
    boldTextAttributes[.font] = UIFont.boldSystemFont(ofSize: 14)

    let text = NSMutableAttributedString(string: "Please", attributes: plainTextAttributes)
    text.append(NSAttributedString(string: " stay on this screen ", attributes: boldTextAttributes))
    text.append(NSAttributedString(string: "while we activate your service. This process may take a few minutes.", attributes: plainTextAttributes))

    subLabel.attributedText = text

    return subLabel
}
```

## Label2

<img src="https://github.com/jrasmusson/ios-starter-kit/blob/master/basics/NSAttributedString/images/paragraph.png" width="400"/>

```swift
let nameLabel: UILabel = {
    let label = UILabel()
    label.numberOfLines = 2

    label.translatesAutoresizingMaskIntoConstraints = false

    let attributedText = NSMutableAttributedString(string: "Kevin Flynn", attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 14)])
    attributedText.append(NSAttributedString(string: "\nFebruary 10 • San Francisco ", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 12), NSAttributedString.Key.foregroundColor: UIColor.gray]))

    let paragraphStyle = NSMutableParagraphStyle()
    paragraphStyle.lineSpacing = 4
    attributedText.addAttribute(NSAttributedString.Key.paragraphStyle, value: paragraphStyle, range: NSMakeRange(0, attributedText.string.count))

    // check mark
    let attachment = NSTextAttachment()
    attachment.image = UIImage(named: "globe_icon")
    attachment.bounds = CGRect(x: 0, y: -2, width: 16, height: 16)
    attributedText.append(NSAttributedString(attachment: attachment))

    label.attributedText = attributedText
    return label

}()
```

Unicode bullet • https://unicode-table.com/en/2022/

## Button

```swift
func makeSpotifyButton(withText title: String) -> UIButton {
    let button = UIButton()
    button.translatesAutoresizingMaskIntoConstraints = false
    button.titleLabel?.minimumScaleFactor = 0.5
    button.titleLabel?.adjustsFontSizeToFitWidth = true
    button.backgroundColor = .spotifyGreen
    button.setTitleColor(.white, for: .normal)
    button.layer.cornerRadius = buttonHeight / 2
    button.contentEdgeInsets = UIEdgeInsets(top: 10, left: buttonHeight, bottom: 10, right: buttonHeight)

    // You are here - add kerning
    let attributedText = NSMutableAttributedString(string: title, attributes: [
        NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 16),
        NSAttributedString.Key.foregroundColor: UIColor.white,
        NSAttributedString.Key.kern: 1
        ])

    button.setAttributedTitle(attributedText, for: .normal)

    return button
}
```
