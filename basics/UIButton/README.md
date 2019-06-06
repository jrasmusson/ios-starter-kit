# UIButton

## How to nudge a button around

```swift
button.contentEdgeInsets = UIEdgeInsets(top: 12, left: Spacing.margin, bottom: Spacing.margin, right: Spacing.margin)
```

## How to control spacing between button and text (edge insets)

https://noahgilmore.com/blog/uibutton-padding/

## How to combine a button with an image

<img src="https://github.com/jrasmusson/ios-starter-kit/blob/master/basics/UIButton/images/button-image.png" width="200"/>

There are multiples ways you can do this - each with there respective pros and cons.

Another way to do this is with `NSAttributedImage` string and add the image to that text. You can also explore setting the image to the right of the button the proper way.

### UIEdgeInsets and flipping semanticContentAttribute

This method is very simple. It adds the text and image to the button and then nudges them around with UIEdge insets. To get the image to appear on the right, `button.semanticContentAttribute = .forceRightToLeft` is applied which requires a smaller offset if you want the image on the right.

The downside to this method is it ignores right to left languages, i.e. it forces the image on the right which may or may not be what you want.

```swift
    private struct LocalSizing {
        static let warningIconSize = CGFloat(24)
        static let buttonHeight = CGFloat(16)
        static let imageWidth = CGFloat(10)
        static let rightPadding = CGFloat(8)
    }

    func makeButton() -> UIButton {
        button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false

        let buttonTitle = "Request payment extension"
        let buttonFont = UIFont.systemFont(ofSize: 14.0)

        button.setTitle(buttonTitle, for: .normal)
        button.setTitleColor(.shawHighlightBlue, for: .normal)
        button.titleLabel?.font = buttonFont

        button.setImage(#imageLiteral(resourceName: "iconDisclosureBlue"), for: .normal)
        button.contentHorizontalAlignment = .left
        button.semanticContentAttribute = .forceRightToLeft
        button.titleEdgeInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: 0.0, right: 8)
        button.imageEdgeInsets = UIEdgeInsets(top: 0.0, left: 8, bottom: 0.0, right: 0.0)
        // button.addTarget(nil, action: nil, for: .primaryActionTriggered)

        // dynamically calculate button width
        let fontAttributes = [NSAttributedString.Key.font: buttonFont]
        var buttonWidth = (buttonTitle as NSString).size(withAttributes: fontAttributes).width
        buttonWidth += LocalSizing.rightPadding + LocalSizing.imageWidth
        button.widthAnchor.constraint(equalToConstant: buttonWidth).isActive = true

        return button
    }
````


## How to make a button with rounded corners

<img src="https://github.com/jrasmusson/ios-starter-kit/blob/master/basics/UIButton/images/button-rounded.png"/>

```swift
func makeRoundCornerButton(title: String) -> UIButton {
    let button = UIButton()
    button.translatesAutoresizingMaskIntoConstraints = false
    button.setTitle(title, for: .normal)
    button.titleLabel?.minimumScaleFactor = 0.5
    button.titleLabel?.font = UIFont.systemFont(ofSize: 16)
    button.titleLabel?.adjustsFontSizeToFitWidth = true
    button.backgroundColor = .blue
    button.setTitleColor(.white, for: .normal)
    button.layer.cornerRadius = 40 / 2
    
    return button
}
```

## How to make a text only button

<img src="https://github.com/jrasmusson/ios-starter-kit/blob/master/basics/UIButton/images/button-as-text.png"/>

```swift
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
```
## How to set image on button

```swift
    let progressButton: UIButton = {
        let button = makeButton(title: "")

        let imageView = UIImageView()
        let image = UIImage(named: "loading_dots_large_white1")
        button.setImage(image, for: .normal)

        return button
    }()
```
<img src="https://github.com/jrasmusson/ios-starter-kit/blob/master/basics/UIButton/images/image-on-button.png"/>




```swift
import UIKit

class ViewController: UIViewController {

    let button: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .green
        button.setTitle("GOT IT", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.contentEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        button.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)

        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        view.addSubview(button)

        button.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        button.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }

    @objc func buttonPressed(sender: UIButton!) {
        print("Button tapped")
    }
    
}
```

## Buttons on UINavigationBar

<img src="https://github.com/jrasmusson/ios-starter-kit/blob/master/basics/UIButton/images/navbar.png" alt="drawing" width="400"/>

```swift
import UIKit

extension HomeController {

    func setupNavigationBarItems() {
        let titleImageView = UIImageView(image: #imageLiteral(resourceName: "title_icon"))
        titleImageView.frame = CGRect(x: 0, y: 0, width: 34, height: 34)
        titleImageView.contentMode = .scaleAspectFit

        navigationItem.titleView = titleImageView

        let followButton = UIButton(type: .system)
        followButton.setImage(#imageLiteral(resourceName: "follow").withRenderingMode(.alwaysOriginal), for: .normal) // alwaysOriginal keeps the original color of the button
        followButton.frame = CGRect(x: 0, y: 0, width: 34, height: 34)
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: followButton)

        let searchButton = UIButton(type: .system)
        searchButton.setImage(#imageLiteral(resourceName: "search").withRenderingMode(.alwaysOriginal), for: .normal)
        searchButton.frame = CGRect(x: 0, y: 0, width: 34, height: 34)
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: searchButton)

        let composeButton = UIButton(type: .system)
        composeButton.setImage(#imageLiteral(resourceName: "compose").withRenderingMode(.alwaysOriginal), for: .normal)
        composeButton.frame = CGRect(x: 0, y: 0, width: 34, height: 34)

        navigationItem.rightBarButtonItems = [UIBarButtonItem(customView: searchButton), UIBarButtonItem(customView: composeButton)]

        navigationController?.navigationBar.backgroundColor = .white
        navigationController?.navigationBar.isTranslucent = false

        // how to adjust navigationBar bottom line (it's actually a shadow)

        // remove the bottom line of navbar
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)

        // and replace with custom
        let navBarSeparatorView = UIView()
        navBarSeparatorView.translatesAutoresizingMaskIntoConstraints = false
        navBarSeparatorView.backgroundColor = UIColor(red: 230/255, green: 230/255, blue: 230/255, alpha: 1)

        view.addSubview(navBarSeparatorView)

        navBarSeparatorView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true // NOTE: top not bottom (I don't know why)
        navBarSeparatorView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        navBarSeparatorView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        navBarSeparatorView.heightAnchor.constraint(equalToConstant: 0.5).isActive = true

    }
    
}
```




