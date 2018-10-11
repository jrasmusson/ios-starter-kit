# How round the corners on a UIImageView

```swift
    let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = #imageLiteral(resourceName: "profile_image")

        imageView.layer.cornerRadius = 5
        imageView.clipsToBounds = true

        return imageView
    }()
```
