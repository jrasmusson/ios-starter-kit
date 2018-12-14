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