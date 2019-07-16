# UIButton

## How to make button text dynamically fit the size of the button

```swift
    func makeButton(title: String) -> UIButton {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle(title, for: .normal)
        button.titleLabel?.adjustsFontSizeToFitWidth = true
        button.contentEdgeInsets = UIEdgeInsets.init(top: 8, left: 16, bottom: 8, right: 16)
        
        return button
    }
```

## How to nudge a button around

```swift
button.contentEdgeInsets = UIEdgeInsets(top: 12, left: Spacing.margin, bottom: Spacing.margin, right: Spacing.margin)
```

## How to control spacing between button and text (edge insets)

https://noahgilmore.com/blog/uibutton-padding/

## How to combine a button with an image

<img src="https://github.com/jrasmusson/ios-starter-kit/blob/master/basics/UIButton/images/button-image.png" width="200"/>

There are multiples ways you can do this - each with there respective pros and cons.

### NSAttributed string

Another way to do this is with `NSAttributedImage` string and add the image to that text. Nice thing about this is you still get left to right localization (unlike other method). Note how you need to set the width constraint on the `titleLabel` inside the button after calculating the width and not on the button itself (near bottom of method).

```swift
    func makePaymentExtensionButton() -> UIButton {
        performPaymentExtensionButton = UIButton()
        performPaymentExtensionButton.translatesAutoresizingMaskIntoConstraints = false

        let title = loc("paymentExtension.homeBanner.delinquent.button")
        let font = UIFont.systemFont(ofSize: 14.0)

        performPaymentExtensionButton.setTitleColor(.shawHighlightBlue, for: .normal)
        performPaymentExtensionButton.titleLabel?.font = font

        var attributes = [NSAttributedString.Key: AnyObject]()
        attributes[.foregroundColor] = UIColor.shawHighlightBlue

        let attributedString = NSMutableAttributedString(string: title, attributes: attributes)

        let image = UIImage(named: "iconDisclosureBlue")!
        let imageAttachment = NSTextAttachment()

        imageAttachment.bounds = CGRect(x: LocalSpacing.buttonPaddingRight, y: -1, width: image.size.width, height: image.size.height) // 8
        imageAttachment.image = image

        let attributedImage = NSAttributedString(attachment: imageAttachment)
        attributedString.append(attributedImage)

        performPaymentExtensionButton.setAttributedTitle(attributedString, for: .normal)

        let width = buttonWidth(forText: title, font: font)
        performPaymentExtensionButton.titleLabel?.widthAnchor.constraint(equalToConstant: width).isActive = true // important titleLabel - not button

        return performPaymentExtensionButton
    }

    func buttonWidth(forText text: String, font: UIFont) -> CGFloat {
        let fontAttributes = [NSAttributedString.Key.font: font]
        var width = (text as NSString).size(withAttributes: fontAttributes).width
        width += LocalSpacing.buttonPaddingRight + LocalSizing.buttonImageWidth // 8 + 10

        return width
    }
```


### UIEdgeInsets

You can add image and text individually to a button and then play with the edge insets. 

```swift
    func makePaymentExtensionButton() -> UIButton {
        performPaymentExtensionButton = UIButton()
        performPaymentExtensionButton.translatesAutoresizingMaskIntoConstraints = false

        let buttonTitle = loc("paymentExtension.homeBanner.delinquent.button")
        let buttonFont = UIFont.systemFont(ofSize: 14.0)

        performPaymentExtensionButton.setTitle(buttonTitle, for: .normal)
        performPaymentExtensionButton.setTitleColor(.shawHighlightBlue, for: .normal)
        performPaymentExtensionButton.titleLabel?.font = buttonFont

        performPaymentExtensionButton.setImage(#imageLiteral(resourceName: "iconDisclosureBlue"), for: .normal)
        performPaymentExtensionButton.contentHorizontalAlignment = .left
//        performPaymentExtensionButton.semanticContentAttribute = .forceRightToLeft
        performPaymentExtensionButton.titleEdgeInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: 0.0, right: 8.0)
        performPaymentExtensionButton.imageEdgeInsets = UIEdgeInsets(top: 0.0, left: 180 + 8 + 10, bottom: 0.0, right: 0.0)
        performPaymentExtensionButton.addTarget(nil, action: .performPaymentExtensionAction, for: .primaryActionTriggered)

        performPaymentExtensionButton.widthAnchor.constraint(equalToConstant: 200).isActive = true

        return performPaymentExtensionButton
    }

    func buttonWidth(forText text: String, font: UIFont) -> CGFloat {
        let fontAttributes = [NSAttributedString.Key.font: font]
        var width = (text as NSString).size(withAttributes: fontAttributes).width
        width += LocalSpacing.buttonPaddingRight + LocalSizing.buttonImageWidth

        return width
    }
````

Note that image start off on the left, so you need to either calculate the width of the button and add a large offset (i.e. 180) along with a width constraint on the button itself.

Or you can force flip the `semanticContentAttribute` to be `.forceRightToLeft` to start the image on the right. But this isn't recommneded as you then lose direction of language.

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




