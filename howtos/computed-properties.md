# How to refactor computed properties

```swift
lazy var chatLabel: UILabel = {
    let label = makeLabel()
    label.text = "Get the best support chat experience"

    return label
}()

func makeLabel() -> UILabel {
    let label = UILabel()

    label.translatesAutoresizingMaskIntoConstraints = false
    label.numberOfLines = 0
    label.lineBreakMode = .byWordWrapping
    label.font = UIFont.systemFont(ofSize: 13)
    label.textColor = UIColor(red: 0.4, green: 0.4, blue: 0.4, alpha: 1)

    return label
}
```