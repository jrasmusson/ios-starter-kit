# Shadows

## Simple drop shadow

![](images/simple.png)

```swift
import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }

    func setup() {
        let width: CGFloat = 300
        let height: CGFloat = 200

        let vw = UIImageView(frame: CGRect(x: 0, y: 0, width: width, height: height))
        vw.image = UIImage(named: "meatless")
        vw.center = view.center
        view.addSubview(vw)
        
        vw.layer.shadowPath = UIBezierPath(rect: vw.bounds).cgPath
        vw.layer.shadowRadius = 1
        vw.layer.shadowOffset = CGSize(width: 0, height: 3)
        vw.layer.shadowOpacity = 0.2
    }
}
```

### Links that help

- [Advanced UIView shadow effects using shadowPath](https://www.hackingwithswift.com/articles/155/advanced-uiview-shadow-effects-using-shadowpath)
- [Swift Tip: Adding Rounded Corners and Shadows to a UIView](https://medium.com/bytes-of-bits/swift-tips-adding-rounded-corners-and-shadows-to-a-uiview-691f67b83e4a)
