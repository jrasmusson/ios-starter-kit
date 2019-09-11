# UIStatusBar

```swift
class ActivateViewController: UIViewController {

    override var prefersStatusBarHidden: Bool {
        return false
    }

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}
```

```swift
public enum UIStatusBarStyle : Int {
    case `default` // Dark content, for use on light backgrounds

    @available(iOS 7.0, *)
    case lightContent // Light content, for use on dark backgrounds
}
```


