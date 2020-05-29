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

### LayoutEdgeAnchorable

```swift
enum LayoutEdgeAnchor {
    case leading
    case trailing
    case top
    case bottom
}

protocol LayoutEdgeAnchorable {
    var leadingAnchor: NSLayoutXAxisAnchor { get }
    var trailingAnchor: NSLayoutXAxisAnchor { get }
    var topAnchor: NSLayoutYAxisAnchor { get }
    var bottomAnchor: NSLayoutYAxisAnchor { get }

    func makeEdgeConstraints(equalToAnchorsOf anchorable: LayoutEdgeAnchorable, forEdges edges: [LayoutEdgeAnchor], insetBy insets: UIEdgeInsets) -> [NSLayoutConstraint]
}

extension LayoutEdgeAnchorable {

    func makeEdgeConstraints(equalToAnchorsOf anchorable: LayoutEdgeAnchorable, forEdges edges: [LayoutEdgeAnchor] = [.top, .leading, .bottom, .trailing], insetBy insets: UIEdgeInsets = .zero) -> [NSLayoutConstraint] {
        return edges.map { edge in
            switch edge {
            case .top:
                return topAnchor.constraint(equalTo: anchorable.topAnchor, constant: insets.top)
            case .leading:
                return leadingAnchor.constraint(equalTo: anchorable.leadingAnchor, constant: insets.left)
            case .bottom:
                return anchorable.bottomAnchor.constraint(equalTo: bottomAnchor, constant: insets.bottom)
            case .trailing:
                return anchorable.trailingAnchor.constraint(equalTo: trailingAnchor, constant: insets.right)
            }
        }
    }

}

extension UIView: LayoutEdgeAnchorable {}
```

## Auto Resizing Mask 

An alternative to autolayout is resizing mask. Two ways to fill a view.

### AutoResizingMask

```swift
let collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createLayout())
collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
view.addSubview(collectionView)
```

### Autolayout

```swift
let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
cv.translatesAutoresizingMaskIntoConstraints = false

addSubview(collectionView)

NSLayoutConstraint.activate([
    collectionView.topAnchor.constraint(equalToSystemSpacingBelow: topAnchor, multiplier: 0),
    collectionView.leadingAnchor.constraint(equalToSystemSpacingAfter: leadingAnchor, multiplier: 0),
    trailingAnchor.constraint(equalToSystemSpacingAfter: collectionView.trailingAnchor, multiplier: 0),
    bottomAnchor.constraint(equalToSystemSpacingBelow: collectionView.bottomAnchor, multiplier: 0)
])
```

### Links that help

- [Anchor API](https://developer.apple.com/documentation/uikit/NSLayoutAnchor)
- [Easier Swift Layout Priorities](https://useyourloaf.com/blog/easier-swift-layout-priorities/)

