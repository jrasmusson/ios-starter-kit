# Button Slider

![Demo](https://github.com/jrasmusson/ios-starter-kit/blob/master/animations/ButtonSlider/images/demo.gif)

This example demonstrates how to use auto layout with animator to make a green slider move back and forth under buttons when pressed.

Magic happens here.

```swift
    @objc func button1Pressed() {
        view.layoutIfNeeded()
        self.sliderCenterButton1.isActive = true
        self.sliderCenterButton2.isActive = false

        UIView.animate(withDuration: 1) {
            self.view.layoutIfNeeded()
        }
    }
```

## Full example

```swift
import UIKit

class SpotifyTabBarController: UIViewController {

    private let slider = Slider()

    private var button1 = UIButton()
    private var button2 = UIButton()

    private var sliderCenterButton1 = NSLayoutConstraint()
    private var sliderCenterButton2 = NSLayoutConstraint()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }

    func setupViews() {
        view.backgroundColor = .yellow

        // buttons
        button1 = makeButton(title: "Paylists")
        button1.addTarget(self, action: #selector(button1Pressed), for: .touchUpInside)

        view.addSubview(button1)

        button1.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8).isActive = true
        button1.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8).isActive = true
        button1.heightAnchor.constraint(equalToConstant: 44).isActive = true

        button2 = makeButton(title: "Podcasts")
        button2.addTarget(self, action: #selector(button2Pressed), for: .touchUpInside)

        view.addSubview(button2)

        button2.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8).isActive = true
        button2.leadingAnchor.constraint(equalTo: button1.trailingAnchor, constant: 8).isActive = true
        button2.heightAnchor.constraint(equalToConstant: 44).isActive = true

        // slider
        slider.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(slider)

        slider.topAnchor.constraint(equalTo: button1.bottomAnchor).isActive = true
        sliderCenterButton1 = slider.centerXAnchor.constraint(equalTo: button1.centerXAnchor)
        sliderCenterButton2 = slider.centerXAnchor.constraint(equalTo: button2.centerXAnchor)
        sliderCenterButton1.isActive = true
    }

    @objc func button1Pressed() {
        view.layoutIfNeeded()
        self.sliderCenterButton1.isActive = true
        self.sliderCenterButton2.isActive = false

        UIView.animate(withDuration: 1) {
            self.view.layoutIfNeeded()
        }
    }

    @objc func button2Pressed() {
        view.layoutIfNeeded()
        self.sliderCenterButton1.isActive = false
        self.sliderCenterButton2.isActive = true

        UIView.animate(withDuration: 1) {
            self.view.layoutIfNeeded()
        }
    }

}

// MARK: - Factories

extension SpotifyTabBarController {
    func makeButton(title: String) -> UIButton {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle(title, for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.contentEdgeInsets = UIEdgeInsets.init(top: 8, left: 16, bottom: 8, right: 16)

        return button
    }
}

```

```swift
import UIKit

class Slider: UIView {

    override init(frame: CGRect) {
        super.init(frame: .zero)
        backgroundColor = .green
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override var intrinsicContentSize: CGSize {
        return CGSize(width: 70, height: 8)
    }
}
```



### Links that help
* [Use your loaf](https://useyourloaf.com/blog/quick-guide-to-property-animators/)
