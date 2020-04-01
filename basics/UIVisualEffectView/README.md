# UIVisualEffectView / Materials

iOS provides materials (or blur effects) that create a translucent effect you can use to evoke a sense of depth. The effect of a material lets views and controls hint at background content without distracting from foreground content. To produce this effect, materials allow background color information to pass through foreground views, while also blurring the background context to maintain legibility.

When you use the system-defined materials, your elements look great in every context, because these effects automatically adapt to the system’s light and dark modes.

<img src="https://github.com/jrasmusson/ios-starter-kit/blob/master/basics/UIVisualEffectView/images/vibrancy.png" alt="drawing" width="400"/>


```swift
import UIKit

class VibrancyViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }

    func setupViews() {

        // Image
        let imageView = UIImageView(image: UIImage(named: "tron"))
        imageView.frame = view.bounds
        imageView.contentMode = .scaleAspectFit
        view.addSubview(imageView)

        // Blur
        let blurEffect = UIBlurEffect(style: .systemUltraThinMaterial)
        let blurredEffectView = UIVisualEffectView(effect: blurEffect)
        blurredEffectView.frame = imageView.bounds
        view.addSubview(blurredEffectView)

        // Vibrancy
        let segmentedControl = UISegmentedControl(items: ["First Item", "Second Item"])
        segmentedControl.sizeToFit()
        segmentedControl.center = view.center

        let vibrancyEffect = UIVibrancyEffect(blurEffect: blurEffect)
        let vibrancyEffectView = UIVisualEffectView(effect: vibrancyEffect)
        vibrancyEffectView.frame = imageView.bounds

        vibrancyEffectView.contentView.addSubview(segmentedControl)
        blurredEffectView.contentView.addSubview(vibrancyEffectView)
    }
}
```

## Materials

<img src="https://github.com/jrasmusson/ios-starter-kit/blob/master/basics/UIVisualEffectView/images/materials.png" alt="drawing" width="800"/>

Materials is just one of many blur options you have for adding vibrancy to your views controls.

<img src="https://github.com/jrasmusson/ios-starter-kit/blob/master/basics/UIVisualEffectView/images/options.png" alt="drawing"/>


### Links that help

- [Apple Materials](https://developer.apple.com/design/human-interface-guidelines/ios/visual-design/materials/)
- [UIVisualEffectView](https://developer.apple.com/documentation/uikit/uivisualeffectview)
- [Example 1](https://www.raywenderlich.com/167-uivisualeffectview-tutorial-getting-started)
- [Example 2](https://www.hackingwithswift.com/example-code/uikit/how-to-add-blur-and-vibrancy-using-uivisualeffectview)
