# Breakable constraints

Sometimes with different screen sizes, you need some constraints that are required, and others that are nice-to-have. Here is an example of a screen with a

*  `UIImageView` that grows and shrinks for different screen sizes
*  `UIButton` that tries to push itself hight, while having a minium low

And it all works because some constraints are firm (priority = 1000) while others are breakable (anything < 1000).

```swift
func makeImageView(named: String) -> UIImageView {
    let imageView = UIImageView()
    imageView.translatesAutoresizingMaskIntoConstraints = false
    imageView.contentMode = .scaleAspectFit
    imageView.image = UIImage(named: named)

    return imageView
}
```

```swift
import UIKit

class HeroView: UIView {

    init(frame: CGRect, named: String) {
        super.init(frame: frame)

        let heroImageView = makeImageView(named: named)

        addSubview(heroImageView)

        heroImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 0).isActive = true
        heroImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0).isActive = true
        heroImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0).isActive = true
        heroImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0).isActive = true

        heroImageView.setContentHuggingPriority(UILayoutPriority(rawValue: 249), for: .vertical)
        heroImageView.setContentCompressionResistancePriority(UILayoutPriority(rawValue: 749), for: .vertical)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
```

```swift
import UIKit

class GetStartedViewController: UIViewController {

    let gettingStartedbutton: UIButton = {
        let button = makeShawButton(title:"Get started")
        button.addTarget(self, action: #selector(gettingStartedPressed), for: .touchUpInside)

        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()
        setupNavigationBar()
    }

    func setupViews() {
        view.backgroundColor = .white

        let heroView = makeHeroView(named: "activation_intro")
        let heroLabel = makeHeroLabel(text: "Let's get you online and connected")

        let setupImageView = makeImageView(named: "setup")
        let activateImageView = makeImageView(named: "hitron")
        let connectImageView = makeImageView(named: "connect")

        let setupLabel = makeGrayTextBoldLabel(text: "Set up")
        let activateLabel = makeGrayTextBoldLabel(text: "Activate")
        let connectLabel = makeGrayTextBoldLabel(text: "Connect")

        let chevronLeft = makeImageView(named: "chevron")
        let chevronRight = makeImageView(named: "chevron")

        let stackImages = makeStackImagesView()
        stackImages.addArrangedSubview(setupImageView)
        stackImages.addArrangedSubview(activateImageView)
        stackImages.addArrangedSubview(connectImageView)

        let stackLabels = makeStackLabelsView()
        stackLabels.addArrangedSubview(setupLabel)
        stackLabels.addArrangedSubview(chevronLeft)
        stackLabels.addArrangedSubview(activateLabel)
        stackLabels.addArrangedSubview(chevronRight)
        stackLabels.addArrangedSubview(connectLabel)

        view.addSubview(heroView)
        view.addSubview(heroLabel)
        view.addSubview(stackImages)
        view.addSubview(stackLabels)
        view.addSubview(gettingStartedbutton)

        heroView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8).isActive = true
        heroView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 0).isActive = true
        heroView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16).isActive = true
        heroView.bottomAnchor.constraint(equalTo: heroLabel.topAnchor, constant: -8).isActive = true

        heroLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        heroLabel.widthAnchor.constraint(equalToConstant: 300).isActive = true

        stackImages.topAnchor.constraint(equalTo: heroLabel.bottomAnchor, constant: 28).isActive = true
        stackImages.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 40).isActive = true
        stackImages.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -40).isActive = true

        stackLabels.topAnchor.constraint(equalTo: stackImages.bottomAnchor, constant: 12).isActive = true
        stackLabels.centerXAnchor.constraint(equalTo: stackImages.centerXAnchor).isActive = true
        stackLabels.widthAnchor.constraint(equalTo: stackImages.widthAnchor).isActive = true

        // same width
        setupLabel.widthAnchor.constraint(equalTo: activateLabel.widthAnchor).isActive = true
        activateLabel.widthAnchor.constraint(equalTo: activateLabel.widthAnchor).isActive = true
        setupLabel.widthAnchor.constraint(equalTo: connectLabel.widthAnchor).isActive = true

        // same width
        setupLabel.centerXAnchor.constraint(equalTo: setupImageView.centerXAnchor).isActive = true
        activateLabel.centerXAnchor.constraint(equalTo: activateImageView.centerXAnchor).isActive = true
        connectLabel.centerXAnchor.constraint(equalTo: connectImageView.centerXAnchor).isActive = true

        chevronRight.widthAnchor.constraint(equalTo: chevronLeft.widthAnchor).isActive = true

        gettingStartedbutton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        gettingStartedbutton.heightAnchor.constraint(equalToConstant: layout.CTAButtonHeight).isActive = true
        gettingStartedbutton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24).isActive = true
        gettingStartedbutton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24).isActive = true

        // breakables
        gettingStartedbutton.topAnchor.constraint(greaterThanOrEqualTo: stackLabels.bottomAnchor, constant: 44).setActiveBreakable(priority: .defaultHigh)
        gettingStartedbutton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: layout.CTAButtomButtonSpacer).setActiveBreakable(priority: .defaultHigh)
        gettingStartedbutton.bottomAnchor.constraint(greaterThanOrEqualTo: view.bottomAnchor, constant: -8).setActiveBreakable(priority: .defaultLow)
    }

    func setupNavigationBar() {
        let rightBarButtonItem = makeCloseRightBarButtonItem()
        rightBarButtonItem.target = self
        rightBarButtonItem.action = #selector(GetStartedViewController.dismissPressed(sender: ))

        self.navigationItem.rightBarButtonItem = rightBarButtonItem
    }

    @objc func gettingStartedPressed(sender: UIButton!) {
        navigationItem.blankNavigationControllerBackButton()
        navigationController?.pushViewController(SetupViewController(), animated: true)
    }

    @objc func dismissPressed(sender: Any?) {
        dismiss(animated: true, completion: nil)
    }

    func makeStackImagesView() -> UIStackView {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.alignment = .center
        stackView.spacing = 24.0

        return stackView
    }

    func makeStackLabelsView() -> UIStackView {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.alignment = .center
        stackView.spacing = 0

        return stackView
    }

}

public extension NSLayoutConstraint {
    @objc public func setActiveBreakable(priority: UILayoutPriority = UILayoutPriority(900)) {
        self.priority = priority
        isActive = true
    }
}
```

<img src="https://github.com/jrasmusson/ios-starter-kit/blob/master/autolayout/images/breakable-constraints.png" alt="drawing" />
