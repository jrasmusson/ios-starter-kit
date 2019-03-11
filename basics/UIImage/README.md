# UIImage

## Stretch able image

<img src="https://github.com/jrasmusson/ios-starter-kit/blob/master/basics/UIImage/images/stretchable-image.png"/>

First define a custom column flow layout that specifies the width, height, and insets of each item in your collection.


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
