# Control Factory

```swift
import UIKit

typealias Layout = ActivationLayout

struct ActivationLayout {
    static let discLogoRadius: CGFloat = 35
    static let CTAButtomButtonSpacer: CGFloat = -80
    static let CTAButtonHeight:CGFloat = 40
}

// MARK: - Hero

func makeHeroView(named: String) -> UIView {
    let view = HeroView(frame: CGRect.zero, named: named)
    view.translatesAutoresizingMaskIntoConstraints = false

    return view
}

func makeHeroLabel(text: String) -> UILabel {
    let label = makeLabel(text: text)
    label.font = UIFont(name: "Company-Bold", size: 28)
    label.text = text

    return label
}

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

// MARK: - Label

func makeLabel(text: String) -> UILabel {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.text = text
    label.textAlignment = .center
    label.textColor = .black
    label.font = UIFont(name: "Company-Medium", size: 18)
    label.numberOfLines = 0

    return label
}

func makeTitleLabel(text: String) -> UILabel {
    let label = makeLabel(text: text)
    label.font = UIFont(name: "Company-Medium", size: 24)
    label.textColor = .black

    return label
}

func makeGrayTextBoldLabel(text: String) -> UILabel {
    let label = makeLabel(text: text)
    label.font = UIFont.boldSystemFont(ofSize: 16)
    label.textColor = .gray
    label.text = text

    return label
}

func makeGrayTextLabel(text: String) -> UILabel {
    let label = makeLabel(text: text)
    label.font = UIFont.systemFont(ofSize: 16)
    label.textColor = .gray

    return label
}

func makeSmallGrayTextLabel(text: String) -> UILabel {
    let label = makeGrayTextLabel(text: text)
    label.font = UIFont.systemFont(ofSize: 14)

    return label
}

// MARK: - Button

func makeCompanyButton(title: String) -> UIButton {
    let button = UIButton()
    button.translatesAutoresizingMaskIntoConstraints = false
    button.setTitle(title, for: .normal)
    button.titleLabel?.font = UIFont(name: "Company-Medium", size: 20)
    button.backgroundColor = companyBlue()
    button.setTitleColor(.white, for: .normal)
    button.layer.cornerRadius = Layout.CTAButtonHeight / 2

    return button
}

func makeButton(title: String, color: UIColor) -> UIButton {
    let button = makeCompanyButton(title: title)
    button.backgroundColor = color

    return button
}

func makeCloseRightBarButtonItem() -> UIBarButtonItem {
    let barButtonItem = UIBarButtonItem(image: UIImage(named: "close_x"), style: .plain, target: nil, action: nil)

    return barButtonItem
}

func makeDoneRightBarButtonItem() -> UIBarButtonItem {
    let barButtonItem = UIBarButtonItem(title: "Done", style: .plain, target: nil, action: nil)

    return barButtonItem
}

// MARK: - Image

func makeImageView(named: String) -> UIImageView {
    let imageView = UIImageView()
    imageView.translatesAutoresizingMaskIntoConstraints = false
    imageView.contentMode = .scaleAspectFit
    imageView.image = UIImage(named: named)

    return imageView
}

// MARK: Supporting methods

func checkForErrors(error: Error?) {
    guard error == nil else {
        preconditionFailure(String(describing: error))
    }
}

func companyBlue() -> UIColor {
    return UIColor(red:0, green:0.65, blue:0.94, alpha:1)
}

func makeStackView() -> UIStackView {
    let stackView = UIStackView()
    stackView.translatesAutoresizingMaskIntoConstraints = false
    stackView.axis = .vertical
    stackView.alignment = .fill
    stackView.spacing = 8
    stackView.distribution = .fill

    return stackView
}

extension UINavigationItem {

    func blankNavigationControllerBackButton() {
        let backItem = UIBarButtonItem()
        backItem.title = ""
        backBarButtonItem = backItem
    }

}
```
