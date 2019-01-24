# Autolayout Cheat Sheet

## Screen width and height

```swift
problemView.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height).isActive = true
problemView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width).isActive = true
```
## Available screen area

```swift
let window = UIApplication.shared.keyWindow
let topPadding = window?.safeAreaInsets.top
let bottomPadding = window?.safeAreaInsets.bottom
let visibleHeight: CGFloat = (window?.bounds.height)! - topPadding! - bottomPadding!
```

## Multiplier

```swift
// for when you want a multiplier on a view - this view will be 0.8 of the bottom view
NSLayoutConstraint(item: animationView,
                           attribute: .bottom,
                           relatedBy: .equal,
                           toItem: view,
                           attribute: .bottom,
                           multiplier: 0.8,
                           constant: 0.0).isActive = true
```

## Hints

```
manageButtonsWrapper.accessibilityHint = "ManageStack"
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
