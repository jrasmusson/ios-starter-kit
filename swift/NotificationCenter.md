# Notification Center

Here is an example of how to use `NotificationCenter`. 

One convention is to use _Did_ in the name.

```swift
extension Notification.Name {
     static let ActivationDidFail = Notification.Name("ActivationDidFail")
}

// or like this
public let ActivationDidFail: NSNotification.Name = NSNotification.Name(rawValue: "ActivationDidFail")
```

Register for like this

```swift
NotificationCenter.default.addObserver(self, selector: #selector(performActivationDidFailAction),
name: ActivationDidFail, object: nil)
```

Then post

```swift
NotificationCenter.default.post(name: ActivationDidFail, object: nil)
```

### How to send data

User the `userInfo` Dictionary. Send it like this

```swift
let userInfo:[String: UIImage] = ["image": image]
NotificationCenter.default.post(name: .ActivationDidFail, object: self, userInfo: userInfo)
```

Then receive it like this

```swift
func performActivationDidFailAction(notification: Notification) {
     if let image = notification.userInfo?["image"] as? UIImage {
       // do something with your image   
     }
}
```

### Links that help
* [Example from web](https://medium.com/@JoyceMatos/using-nsnotificationcenter-in-swift-eb70cf0b60fc)

