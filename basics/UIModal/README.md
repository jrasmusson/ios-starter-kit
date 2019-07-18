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

CrossDisolve
![TableView](https://github.com/jrasmusson/ios-starter-kit/blob/master/basics/UIModal/images/crossDisolve.gif)

FlipHorizontal
![TableView](https://github.com/jrasmusson/ios-starter-kit/blob/master/basics/UIModal/images/flipHorizontal.gif)

OverfullScreen
![TableView](https://github.com/jrasmusson/ios-starter-kit/blob/master/basics/UIModal/images/overfullscreen.gif)

PartialCurl
![TableView](https://github.com/jrasmusson/ios-starter-kit/blob/master/basics/UIModal/images/partialCurl.gif)


### Links that help

* [Apple Docs](https://developer.apple.com/documentation/uikit/uimodalpresentationstyle)
