# How NSMutableAttributedString

Here are some cool things you can do with `NSMutableAttributedString`s.

## Kerning

```swift
func makeReadyToActivateLabel() -> UILabel {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.textAlignment = .center
    label.textColor = .darkGray
    label.font = UIFont.systemFont(ofSize: 10)
    label.numberOfLines = 0

    // kerning
    let attributedText = NSMutableAttributedString(string: "READY TO ACTIVATE")
    attributedText.addAttribute(NSAttributedString.Key.kern, value: 10, range: NSRange(location: 0, length: attributedText.length - 1))

    label.attributedText = attributedText

    return label
}
```

<img src="https://github.com/jrasmusson/ios-starter-kit/blob/master/howtos/images/kerning.png"/>

## Multiline with different formatting and text

```swift
let nameLabel: UILabel = {
    let label = UILabel()
    label.numberOfLines = 2

    label.translatesAutoresizingMaskIntoConstraints = false

    let attributedText = NSMutableAttributedString(string: "Kevin Flynn", attributes: [NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: 14)])
    attributedText.append(NSAttributedString(string: "\nFebruary 10 • San Francisco ", attributes: [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 12), NSAttributedStringKey.foregroundColor: UIColor.gray]))

    let paragraphStyle = NSMutableParagraphStyle()
    paragraphStyle.lineSpacing = 4
    attributedText.addAttribute(NSAttributedStringKey.paragraphStyle, value: paragraphStyle, range: NSMakeRange(0, attributedText.string.count))

    // check mark
    let attachment = NSTextAttachment()
    attachment.image = UIImage(named: "globe_icon")
    attachment.bounds = CGRect(x: 0, y: -2, width: 16, height: 16)
    attributedText.append(NSAttributedString(attachment: attachment))

    label.attributedText = attributedText
    return label

}()
```

<img src="https://github.com/jrasmusson/ios-starter-kit/blob/master/howtos/images/image-with-text.png"/>


