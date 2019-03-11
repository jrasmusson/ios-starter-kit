# UIImage

## Stretch able image

<img src="https://github.com/jrasmusson/ios-starter-kit/blob/master/basics/UIImage/images/stretchable-image.png" width="600px"/>

Use this technique when you need to stretch a part of an image out to the side. The `325` number used is relative to the diminensions of the image itself. So the part of the image that gets stretch is the area between 325 from the left and 325 fron the right.

```swift
import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }

    func setupViews() {
        view.backgroundColor = .red

        let heroImage = UIImage(named: "hitron_connect")!
        let resizable = heroImage.resizableImage(withCapInsets: UIEdgeInsets(top: 0, left: 325, bottom: 0, right: 325), resizingMode: .stretch)
        let heroView = UIImageView(image: resizable)

        heroView.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(heroView)

        heroView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        heroView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8).isActive = true
        heroView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8).isActive = true
    }
}
```

### Links that help

* [Example](https://stackoverflow.com/questions/35607634/set-stretching-parameters-for-images-programmatically-in-swift-for-ios)
