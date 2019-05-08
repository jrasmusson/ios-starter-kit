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
