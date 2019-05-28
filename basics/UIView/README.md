# UIView

## How to rounded container

<img src="https://github.com/jrasmusson/ios-starter-kit/blob/master/basics/UIView/images/rounded-container.png" alt="drawing" width="400"/>

The trick with the rounded container is to give the `UIView` an `intrinsicContentSize`. Once you do that, the view knows how to lay it out.

```swift
import UIKit

public class RoundedContainer: UIView {

    let cornerRadius: CGFloat = 22

    override init(frame: CGRect) {
        super.init(frame: frame)

        setupView()
    }

    func setupView() {
        translatesAutoresizingMaskIntoConstraints = false

        backgroundColor = .gray
        layer.cornerRadius = cornerRadius

        let accountLabel = makeAccountLabel(text: "Comp. Account 03300000842")

        addSubview(accountLabel)

        accountLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        accountLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override public var intrinsicContentSize: CGSize {
        return CGSize(width: 210, height: cornerRadius * 2)
    }

    // MARK - Factory methods

    func makeAccountLabel(text: String) -> UILabel {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = text
        label.textAlignment = .left
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 13)
        label.numberOfLines = 1

        return label
    }

}
```

And then use it like this.

```swift
import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }

    func setupViews() {
        let container = RoundedContainer()

        view.addSubview(container)

        container.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0).isActive = true
        container.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 0).isActive = true
    }

}
```

### Sticking it in a stackView

When you stick it in a `UIStackView` you may need to adjust the CHCR (i.e. make it hug) else it will will the stackView depending on what settings you use in your stackView (i.e. distribution/alignment = fill).

For example if we setup our stackView to take up the entire view, and default it to fill, the view inside it will expand to the full view accordingly.

```swift
    func setupViews() {
        let stackView = makeStackView(axis: .vertical)

        let container = RoundedContainer()

        stackView.addArrangedSubview(container)

        view.addSubview(stackView)

        stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0).isActive = true
        stackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 0).isActive = true
        stackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: 0).isActive = true
    }
```

<img src="https://github.com/jrasmusson/ios-starter-kit/blob/master/basics/UIView/images/rounded-no-hug.png" alt="drawing" width="400"/>

But if we increase the hugging factor on the container, or try changing the constrains on the stackView itself (i.e. not pinning to trailing side) it will respect its original `intrinsicContentSize` while sitting in a stackView.

(still experimenting with this)

```swift
    func setupViews() {
        let stackView = makeStackView(axis: .vertical)
        stackView.alignment = .center
        let container = RoundedContainer()

        stackView.addArrangedSubview(container)

        view.addSubview(stackView)

//        container.setContentHuggingPriority(.defaultLow + 1, for: .horizontal) // hug
//        container.setContentHuggingPriority(.required + 1, for: .horizontal) // hug

        stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0).isActive = true
        stackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 0).isActive = true
//        stackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: 0).isActive = true
    }
```

<img src="https://github.com/jrasmusson/ios-starter-kit/blob/master/basics/UIView/images/rounded-in-stackview.png" alt="drawing" width="400"/>


## How to create tile with shadow

<img src="https://github.com/jrasmusson/ios-starter-kit/blob/master/basics/UIView/images/tile.png" alt="drawing" width="400"/>


Define your custom tile `UIView` like this.

```swift
import UIKit

public struct Constants {
    public static let cornerRadiusSmall = CGFloat(5) // 2
}

class TileView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)

        setupViews()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupViews() {
        translatesAutoresizingMaskIntoConstraints = false

        backgroundColor = .white
        layer.cornerRadius = Constants.cornerRadiusSmall
        addShadow()
    }
}

public extension UIView {
    @objc func addShadow() {
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.80 // 0.4
        layer.shadowOffset = CGSize(width: -5, height: 5) // -1 1
        layer.shadowRadius = Constants.cornerRadiusSmall
        layer.masksToBounds = false
    }
}
```
And then use it in your `UIViewController` like this

```swift
import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }

    func setupViews() {
        view.backgroundColor = .red

        let tileView = TileView()

        view.addSubview(tileView)

        let margin: CGFloat = 20
        tileView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: margin).isActive = true
        tileView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: margin).isActive = true
        tileView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -margin).isActive = true
        tileView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -margin).isActive = true
    }
}
```


## Decompose big ViewControllers into smaller Views

Here is an example of how to exact a `UIStackView` into it's own `UIView`. Basically create the new view, and pin the stackView to it's edges. Yes you have an extra container view that you didn't have before, but you also have a much easier to understand view and viewController.

```swift
import UIKit

class DownloadView: UIView {

    override init(frame: CGRect) {
        super.init(frame: .zero)

        setupView()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupView() {
        let downloadStackView = makeStackView(axis: .horizontal)

        ...
        
        self.addSubview(downloadStackView)

        downloadStackView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor).isActive = true
        downloadStackView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor).isActive = true
        downloadStackView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor).isActive = true
        downloadStackView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor).isActive = true
    }

}
```

## Custom constructor

When creating a custom view, all non-optional variables have to be initialized before you call `super`.

“Swift’s compiler performs four helpful safety-checks to make sure that two-phase initialization is completed without error:”

Safety check 1 “A designated initializer must ensure that all of the “properties introduced by its class are initialized before it delegates up to a superclass initializer.”	

```swift
class ModemSpecificSupportView: UIView {

    let title: String

    init(title: String) {
        self.title = title

        super.init(frame: .zero)

        setupViews()
        fetchArticles()
    }
```

## Defining objects as variables but not instantating them till later

Because of how Swift does a two phase initialization process on objects, you need to have all your properties defined before you instantiate your object. This can be a bit of a pain, as you would like your objects laid out in the order they are created without having to define earily.

One way around this is to define a dummy or empty object early, and then set the real one later during construction.

```swift
class ModemSpecificSupportView: UIView {

    // temp
    var row1 = SupportArticleRowView()
    var row2 = SupportArticleRowView()
    var row3 = SupportArticleRowView()

    init(title: String) {
        super.init(frame: .zero)
        setupViews()
    }

    func setupViews() {
        backgroundColor = .white

        // real
        row1 = makeRowView()
        row2 = makeRowView()
        row3 = makeRowView()
 ```
