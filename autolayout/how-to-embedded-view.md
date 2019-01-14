# How to do autolayout with custom UIView

<img src="https://github.com/jrasmusson/ios-starter-kit/blob/master/autolayout/images/embedded-view.png" />

When embedded a `UIView` inside another, the key thing to remember is to treat the `UIView` layout constraints relative to that view and it's parent (think internal to the view).

And then when you add it to the `UIViewController` treat it just like any other button or lable. Add the constraints for show it should fit relative to the other controls in there.

So think internal for the custom view.
Then external when you layout it out in the ViewController.

<img src="https://github.com/jrasmusson/ios-starter-kit/blob/master/autolayout/images/embedded-custom-view.png" />


Here is an example.

```swift
import UIKit

class RowView: UIView {

    override init(frame: CGRect) {
        super.init(frame: .zero)

        setupViews()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupViews() {
        self.backgroundColor = .white

        let button = makeButton(title: "How to install your modem")
        let chevron = makeImageView(named: "chevron")

        addSubview(button)
        addSubview(chevron)

        button.topAnchor.constraint(equalTo: self.topAnchor, constant: 0).isActive = true
        button.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0).isActive = true
        button.heightAnchor.constraint(equalToConstant: 50).isActive = true

        chevron.centerYAnchor.constraint(equalTo: button.centerYAnchor, constant: 0).isActive = true
        chevron.leadingAnchor.constraint(equalTo: button.trailingAnchor, constant: 8).isActive = true
        chevron.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16).isActive = true
        chevron.heightAnchor.constraint(equalToConstant: 16).isActive = true
        chevron.widthAnchor.constraint(equalToConstant: 16).isActive = true
    }

    // MARK: - Factory methods

    func makeButton(title: String) -> UIButton {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle(title, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        button.backgroundColor = .white
        button.setTitleColor(.blue, for: .normal)
        button.titleLabel?.numberOfLines = 0
        button.titleLabel?.lineBreakMode = .byWordWrapping
        button.contentHorizontalAlignment = .left

        return button
    }

    func makeImageView(named: String) -> UIImageView {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: named)
        imageView.backgroundColor = .red

        return imageView
    }

}
```

Notice above that the top anchor and some contraints go right flush against the parent. That's what we want. The other constraints are then relative to the other UI elements, each going flush to the parent (or as much as you want).

```swift
import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()
    }

    func setupViews() {

        view.backgroundColor = .white

        let label = makeHeadingLabel(text: "Help articles")
        let line = makeTitleSeparatorLineView()

        let row = RowView()
        row.translatesAutoresizingMaskIntoConstraints = false // important!

        view.addSubview(label)
        view.addSubview(line)
        view.addSubview(row)

        label.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8).isActive = true
        label.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24).isActive = true
        label.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24).isActive = true

        line.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 16).isActive = true
        line.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24).isActive = true
        line.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
        line.heightAnchor.constraint(equalToConstant: 0.5).isActive = true

        row.topAnchor.constraint(equalTo: line.bottomAnchor, constant: 0).isActive = true
        row.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24).isActive = true
        row.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32).isActive = true
        row.heightAnchor.constraint(equalToConstant: 50).isActive = true

    }

    // MARK: - Factory methods
    func makeHeadingLabel(text: String) -> UILabel {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 18)
        label.textColor = .black
        label.textAlignment = .left
        label.numberOfLines = 0
        label.text = text

        return label
    }

    func makeTitleSeparatorLineView() -> UIView {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .darkGray

        return view
    }

}
```

Then when we layout it out in where it should be used, we just treat like a button. Layout it out like anything else.


