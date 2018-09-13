# How to iOS11 version switch

```swift
        if #available(iOS 11, *) {
            imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 60).isActive = true
        } else {
            imageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 60).isActive = true
        }
```

