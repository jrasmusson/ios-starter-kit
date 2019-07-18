# UIModal

There are two primary modes of displaying `UIViewController`s in modal form along with transitions.

- `modalPresentationStyle`
- `modalTransitionStyle`

```swift
public enum t : Int {
    case fullScreen
    case pageSheet
    case formSheet
    case currentContext
    case custom
    case overFullScreen
    case overCurrentContext
    case popover
    case none
}
    
public enum UIModalTransitionStyle : Int {
    case coverVertical
    case flipHorizontal
    case crossDissolve
    case partialCurl
}
```

Use basically create your ViewController and then set properties as follows

```swift
@objc func buttonPressed() {
    let vc = ModalViewController()
    vc.modalPresentationStyle = .fullScreen
    vc.modalTransitionStyle = .partialCurl

    present(vc, animated: true)
}
```

Here are some of the more interesting outputs.

![TableView](https://github.com/jrasmusson/ios-starter-kit/blob/master/basics/UIScrollView/images/demo.gif)


### Links that help

* [Programmatic UINavigation Controller](https://medium.com/whoknows-swift/swift-the-hierarchy-of-uinavigationcontroller-programmatically-91631990f495)
