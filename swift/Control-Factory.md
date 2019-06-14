# Control Factory

```swift
UIFont.systemFont(ofSize: 14.0)
UIFont.boldSystemFont(ofSize: size)
UIFont(name: "CustomBold", size: size)

import UIKit

typealias Size = ControlSize

public struct ControlSize {
    public static let BigButtonHeight: CGFloat = 50
    public static let MedButtonHeight: CGFloat = 35
}

public struct ControlFactory {

    // MARK: - Image

    public static func makeHeroView(named: String) -> UIView {
        let view = HeroView(frame: CGRect.zero, named: named)
        view.translatesAutoresizingMaskIntoConstraints = false

        return view
    }

    public static func makeImageView(named: String) -> UIImageView {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: named)

        return imageView
    }

    // MARK: - Label

    public static func makeBoldLabel(text: String, size: CGFloat) -> UILabel {
        let label = makeLabel(text: text, size: size)
        label.font = UIFont.boldSystemFont(ofSize: size) // UIFont(name: "CustomBold", size: size)

        return label
    }


    public static func makeLabel(text: String, size: CGFloat) -> UILabel {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = text
        label.textAlignment = .center
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: size)
        label.numberOfLines = 0

        return label
    }

    // MARK: - Stack

    public static func makeStackView(axis: NSLayoutConstraint.Axis = .vertical) -> UIStackView {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = axis
        stackView.alignment = .fill
        stackView.spacing = 8
        stackView.distribution = .fill

        return stackView
    }

    // MARK: - Button

    public static func makeButton(title: String, size: CGFloat = 16) -> UIButton {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle(title, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: size)
        button.setTitleColor(shawBlue(), for: .normal)

        return button
    }

    // MARK: Misc

    public static func shawBlue() -> UIColor {
        return UIColor(red: 0, green: 0.65, blue: 0.94, alpha: 1)
    }
}

// MARK: - Classes

public class HeroView: UIView {

    typealias Factory = ControlFactory

    init(frame: CGRect, named: String) {
        super.init(frame: frame)

        let heroImageView = Factory.makeImageView(named: named)

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
