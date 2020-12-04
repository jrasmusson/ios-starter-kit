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

## How to resize an image to a specific size if it is cut wrong (in this case used for TabBar)

```swift
// Copied from AlamofireImage, in case we remove that dependency in the future
// Used for exact tab bar icon sizing
extension UIImage {
    public func tabBarIconSizedImage() -> UIImage {
        let scaleFactor = 0.7
        let size = CGSize(width: 54.0 * scaleFactor, height: 54.0 * scaleFactor)

        assert(size.width > 0 && size.height > 0, "You cannot safely scale an image to a zero width or height")

        let imageAspectRatio = self.size.width / self.size.height
        let canvasAspectRatio = size.width / size.height

        var resizeFactor: CGFloat

        if imageAspectRatio > canvasAspectRatio {
            resizeFactor = size.width / self.size.width
        } else {
            resizeFactor = size.height / self.size.height
        }

        let scaledSize = CGSize(width: self.size.width * resizeFactor, height: self.size.height * resizeFactor)
        let origin = CGPoint(x: (size.width - scaledSize.width) / 2.0, y: (size.height - scaledSize.height) / 2.0)

        UIGraphicsBeginImageContextWithOptions(size, false, 0.0)
        draw(in: CGRect(origin: origin, size: scaledSize))

        let scaledImage = UIGraphicsGetImageFromCurrentImageContext() ?? self
        UIGraphicsEndImageContext()

        return scaledImage
    }
}
```

### Links that help

* [Example](https://stackoverflow.com/questions/35607634/set-stretching-parameters-for-images-programmatically-in-swift-for-ios)
