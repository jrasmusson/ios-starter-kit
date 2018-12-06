# Image label in a stackview

<img src="https://github.com/jrasmusson/ios-starter-kit/blob/master/autolayout/stackview/ImageLabelStackView/images/demo.png" alt="drawing" width="400"/>

```swift
//
//  ViewController.swift
//  CommonLayout
//
//  Created by Jonathan Rasmusson (Contractor) on 2018-09-04.
//  Copyright © 2018 Jonathan Rasmusson (Contractor). All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Title"
        label.textAlignment = .center
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 17)

        return label
    }()

    let whiteBackgroundView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        view.layer.cornerRadius = 2

        return view
    }()

    let circleImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "square")

        return imageView
    }()

    let headerLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Header title"
        label.textAlignment = .center
        label.numberOfLines = 2
        label.lineBreakMode = .byWordWrapping
        label.font = UIFont.systemFont(ofSize: 21)

        return label
    }()

    let chatImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "check"))
        imageView.contentMode = .scaleAspectFit

        return imageView
    }()

    let chatLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Some text that spills over two lines"
        label.backgroundColor = .green
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.font = UIFont.systemFont(ofSize: 13)

        return label
    }()

    let billingImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "cross"))
        imageView.contentMode = .scaleAspectFit

        return imageView
    }()

    let billingLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Some mawr text that spills over two lines"
        label.backgroundColor = .green
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.font = UIFont.systemFont(ofSize: 13)

        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor(red:0, green:0.51, blue:0.73, alpha:1)

        setupViews()
    }

    func setupViews() {

        // title
        view.addSubview(titleLabel)

        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 34),
            ])

        // white background
        view.addSubview(whiteBackgroundView)

        NSLayoutConstraint.activate([
            whiteBackgroundView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            whiteBackgroundView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            whiteBackgroundView.topAnchor.constraint(equalTo: view.topAnchor, constant: 73),
            whiteBackgroundView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -71),
            ])

        // circleImage
        view.addSubview(circleImageView)

        NSLayoutConstraint.activate([
            circleImageView.topAnchor.constraint(equalTo: whiteBackgroundView.topAnchor, constant: 30),
            circleImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            circleImageView.heightAnchor.constraint(equalToConstant: 72),
            circleImageView.widthAnchor.constraint(equalToConstant: 72),
            ])

        // header
        view.addSubview(headerLabel)

        NSLayoutConstraint.activate([
            headerLabel.topAnchor.constraint(equalTo: circleImageView.bottomAnchor, constant: 21),
            headerLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            headerLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
            ])


        // chat
        let chatStackView = makeNameStackView()

        chatStackView.addArrangedSubview(chatImageView)
        chatStackView.addArrangedSubview(chatLabel)

        // billing
        let billingStackView = makeNameStackView()

        billingStackView.addArrangedSubview(billingImageView)
        billingStackView.addArrangedSubview(billingLabel)

        // container
        let containerStackView = makeRowStackView()

        containerStackView.addArrangedSubview(chatStackView)
        containerStackView.addArrangedSubview(billingStackView)

        // constraints
        chatLabel.widthAnchor.constraint(equalTo: billingLabel.widthAnchor).isActive = true
        chatLabel.widthAnchor.constraint(equalToConstant: 200).isActive = true

        view.addSubview(containerStackView)

        NSLayoutConstraint.activate([
            containerStackView.topAnchor.constraint(equalTo: headerLabel.bottomAnchor, constant: 20),
            containerStackView.leadingAnchor.constraint(equalTo: whiteBackgroundView.leadingAnchor, constant: 20),
            containerStackView.trailingAnchor.constraint(equalTo: headerLabel.trailingAnchor, constant: -20),
            ])
    }

    func makeNameStackView() -> UIStackView {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.distribution = .fill
        stack.alignment = .center // gets them aligned
        stack.spacing = 8.0

        return stack
    }

    func makeRowStackView() -> UIStackView {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.distribution = .fill
        stack.alignment = .fill
        stack.spacing = 8.0

        return stack
    }

}

extension UIColor {
    static func rgb(red: CGFloat, green: CGFloat, blue: CGFloat) -> UIColor {
        return UIColor(red: red/255, green: green/255, blue: blue/255, alpha: 1)
    }
}
```
