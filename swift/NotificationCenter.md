# Notification Center

Here is an example of how to use `NotificationCenter`. 

Define some named events like this

```swift
extension Notification.Name {
     static let peru = Notification.Name("peru")
     static let argentina = Notification.Name("argentina")
}
```

Register for them

```swift
NotificationCenter.default.addObserver(self, selector: #selector(setToPeru(notification:)), name: .peru, object: nil)
NotificationCenter.default.addObserver(self, selector: #selector(setToArgentina(notfication:)), name: .argentina, object: nil)

func setToPeru(notification: NSNotification) {
     cityChosenLabel.text = "Peru"
}

func setToArgentina(notfication: NSNotification) {
     cityChosenLabel.text = "Argentina"
}
```

Then post

```swift
@IBAction func peruButton(_ sender: Any) {
     NotificationCenter.default.post(name: .peru, object: nil)
}
@IBAction func argentinaButton(_ sender: Any) {
     NotificationCenter.default.post(name: .argentina, object: nil
}
```

	Note: Always remember to unregister yourself as an observer when done.
	
```swift
deinit {
     NotificationCenter.default.removeObserver(self)
}
```

### How to send data

User the `userInfo` Dictionary. Send it like this

```swift
let payload:[String: UIImage] = ["image": image]
NotificationCenter.default.post(name: .peru, object: payload)
```

Then receive it like this

```swift
if let image = notification.userInfo?["image"] as? UIImage {
  // do something with your image   
}
```

### Links that help
* [Example from web](https://medium.com/@JoyceMatos/using-nsnotificationcenter-in-swift-eb70cf0b60fc)

