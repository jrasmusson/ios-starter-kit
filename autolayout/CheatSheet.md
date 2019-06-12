# Autolayout Cheat Sheet

## Breakable constraint

```swift
public extension NSLayoutConstraint {
    @objc public func setActiveBreakable(priority: UILayoutPriority = UILayoutPriority(900)) {
        self.priority = priority
        isActive = true
    }
}
```

## Screen width and height

```swift
headerView.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height).isActive = true
headerView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width).isActive = true
```
Note this isn't great if you are rotating the app. Will make very wide and break in landscape.

Better to go with

```swift
headerView.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height).isActive = true
headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
headerView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
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
manageButton.tag = 99
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

### Checkout your negative signs

Sometimes constraints values need to be negative depending on the direction of the constraint.

```swift
textLabel.bottomAnchor.constraint(equalTo: button.topAnchor, constant: -spacing).isActive = true
```

### Default values

Swift has some default values you can use when doing autolayout.

```swift
print("low \(UILayoutPriority.defaultLow.rawValue)")        // 250
print("high \(UILayoutPriority.defaultHigh.rawValue)")      // 750
print("required \(UILayoutPriority.required.rawValue)")     // 1000
```

These are great because instead of doing this you can do this

```swift
container.setContentHuggingPriority(UILayoutPriority(rawValue: 250), for: .horizontal)
container.setContentHuggingPriority(.defaultLow, for: .horizontal)
```

Unfortunately they don't have all the values mapped. And sometimes you need 251.

To make it a little more clear here is an extension that will help you add +/- 1 to the default values.

```swift
extension UILayoutPriority {
  static func +(lhs: UILayoutPriority, rhs: Float) -> UILayoutPriority {
    return UILayoutPriority(lhs.rawValue + rhs)
  }

  static func -(lhs: UILayoutPriority, rhs: Float) -> UILayoutPriority {
    return UILayoutPriority(lhs.rawValue - rhs)
  }
}
```

Now you can write nice clean code like this

```swift
container.setContentHuggingPriority(.defaultLow, for: .horizontal)
```

### Local sizing and spacing

```swift
    struct LocalSizing {
        static let imageSize = CGFloat(18)
    }
```

### Links that help

[Easier Swift Layout Priorities](https://useyourloaf.com/blog/easier-swift-layout-priorities/)

