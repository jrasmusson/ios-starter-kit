# Autolayout Cheat Sheet

```swift
someView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 8).isActive = true
someView.topAnchor.constraint(equalTo: self.topAnchor, constant: 8).isActive = true
someView.widthAnchor.constraint(equalToConstant: 44).isActive = true
someView.heightAnchor.constraint(equalToConstant: 44).isActive = true

textView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.3).isActive = true

middleNameLabel.setContentHuggingPriority(UILayoutPriority(rawValue: 251), for: .horizontal)
middleNameTextField.setContentHuggingPriority(UILayoutPriority(rawValue: 48), for: .horizontal);

// for when you want a multiplier on a view - this view will be 0.8 of the bottom view
NSLayoutConstraint(item: animationView,
                           attribute: .bottom,
                           relatedBy: .equal,
                           toItem: view,
                           attribute: .bottom,
                           multiplier: 0.8,
                           constant: 0.0).isActive = true
```

## Things to remember

#### Set translatesAutoresizingMaskIntoConstraints = false on every view

```swift
stackView.translatesAutoresizingMaskIntoConstraints = false
```

### Ensure all constraints are active

```swift
chatLabel.widthAnchor.constraint(equalToConstant: 200).isActive = true
```

### Add your subviews to the the view

```swift
addSubview(thumbnailImageView)
```
