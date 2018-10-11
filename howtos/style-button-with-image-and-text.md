# How to style button with image and text

```swift
    let followButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false

        button.layer.cornerRadius = 5
        button.layer.borderColor = UIColor.cyan.cgColor
        button.layer.borderWidth = 1
        button.clipsToBounds = true

        button.setTitle("Follow", for: .normal)
        button.setTitleColor(.cyan, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.setImage(#imageLiteral(resourceName: "follow"), for: .normal)
        button.imageView?.contentMode = .scaleAspectFit // 1:1 ratio
        button.imageEdgeInsets = UIEdgeInsets(top: 0, left: -8, bottom: 0, right: 0)
        button.titleEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: -4)

        return button
    }()
```

<img src="https://github.com/jrasmusson/ios-starter-kit/blob/master/howtos/images/style-button-image-and-text.png" alt="drawing" width="400"/>

