# Facebook News Feeds

![Demo](https://github.com/jrasmusson/ios-starter-kit/blob/master/animations/BasicAnimation/images/demo.gif)

## How to create a application without a storyboard

Delete the storyboard from the project.

Delete the keyword `Main` from project `Deployment Info` `Main Interface` section.

Delete `Main storyboard file base name` entry from `Info.plist`.

Then instantiate your `ViewController` in `AppDelegate`


```swift
func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
    
    window = UIWindow(frame: UIScreen.main.bounds)
    window?.makeKeyAndVisible()
    
    let feedController = FeedController(collectionViewLayout: UICollectionViewFlowLayout())
    let navigatorController = UINavigationController(rootViewController: feedController)
    window?.rootViewController = navigatorController
    
    return true
}
```

## How to layout cell

Step 1: Layout the nameLabel

```swift
// nameLabel
nameLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
nameLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
nameLabel.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
nameLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
    
// addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[v0]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": nameLabel]))
// addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[v0]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": nameLabel]))
```

![Demo](https://github.com/jrasmusson/ios-starter-kit/blob/master/examples/FacebookNewsFeed/images/nameLabel.png)


Step 2: Add the profileImageView

```swift
func setupViews() {
    backgroundColor = .white
    
    addSubview(nameLabel)
    addSubview(profileImageView)
    
    // profileImageView
    profileImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
    profileImageView.trailingAnchor.constraint(equalTo: nameLabel.leadingAnchor).isActive = true
    profileImageView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
    profileImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
    
    // nameLabel
    nameLabel.leadingAnchor.constraint(equalTo: profileImageView.trailingAnchor).isActive = true
    nameLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
    nameLabel.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
    nameLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
}
```

![Demo](https://github.com/jrasmusson/ios-starter-kit/blob/master/examples/FacebookNewsFeed/images/imageView.png)


Step 3: Give the imageView height and width.

Here we need to turn off the bottom contstraint when we give the imageView height and width. Else we would get a constraint violation (can't be a fixed width and touch the bottom).

```
    // profileImageView
    profileImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
    profileImageView.trailingAnchor.constraint(equalTo: nameLabel.leadingAnchor).isActive = true
    profileImageView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
//  profileImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
    profileImageView.widthAnchor.constraint(equalToConstant: 44).isActive = true
    profileImageView.heightAnchor.constraint(equalToConstant: 44).isActive = true
    
    // nameLabel
    nameLabel.leadingAnchor.constraint(equalTo: profileImageView.trailingAnchor).isActive = true
    nameLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
    nameLabel.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
    nameLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
```

![Demo](https://github.com/jrasmusson/ios-starter-kit/blob/master/examples/FacebookNewsFeed/images/height-and-width.png)


Step 4: Give is some spacing (8pts border).

By giving the imageView some padding, we also either need to give the same padding on the label constraint, else remove it all together as it will conflict and or be redundant.

-  Note: A constant can be positive or negative depending on where you add it.
-  Note: If you get a violation, but think it should work, try a negative

```swift    
    // profileImageView
    profileImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 8).isActive = true
    profileImageView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
//  profileImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -8).isActive = true // redundant, but will only work if -8    
    profileImageView.widthAnchor.constraint(equalToConstant: 44).isActive = true
    profileImageView.heightAnchor.constraint(equalToConstant: 44).isActive = true
    
    // nameLabel
    nameLabel.leadingAnchor.constraint(equalTo: profileImageView.trailingAnchor, constant: 8).isActive = true // or -8 if added above
    nameLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
    nameLabel.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
    nameLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
```

![Demo](https://github.com/jrasmusson/ios-starter-kit/blob/master/examples/FacebookNewsFeed/images/labels.png)

## How to two line string varying font and color

You could do this with two `UILabel`s and an `UImageView` but another way is to do it all with `NSAttributableString`s.

// image two line label

```swift
    let nameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        
        label.translatesAutoresizingMaskIntoConstraints = false
        
        let attributedText = NSMutableAttributedString(string: "Kevin Flynn", attributes: [NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: 14)])
        attributedText.append(NSAttributedString(string: "\nFebruary 10 • San Francisco ", attributes: [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 12), NSAttributedStringKey.foregroundColor: UIColor.gray]))
    
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 4
        attributedText.addAttribute(NSAttributedStringKey.paragraphStyle, value: paragraphStyle, range: NSMakeRange(0, attributedText.string.count))
        
        // check mark
        let attachment = NSTextAttachment()
        attachment.image = UIImage(named: "Apply")
        attachment.bounds = CGRect(x: 0, y: -2, width: 16, height: 16)
        attributedText.append(NSAttributedString(attachment: attachment))
        
        label.attributedText = attributedText
        return label
        
    }()
```

## Adding the UIImageView and Status message

To add the big image at the bottom, we first need to make the cell larger (i.e. 200). But when we run that we see we need to adjust our name label cell to be more flush with the top.

// about-to-add-image

We can do this by getting rid of the `bottomAnchor` on the name label and adding 8 constant to the `topAnchor`.

```swift
    // nameLabel
    nameLabel.leadingAnchor.constraint(equalTo: profileImageView.trailingAnchor, constant: 8).isActive = true // or -8 if added above
    nameLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
    nameLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 8).isActive = true
```

// no bottom anchor

Now, to add the status message, we can put it 4pts below the profile image view, and pad it 8pts just like the others. Note: We need a height constraints on the status view because `UITextView` does not have an intrinsic height. So we specifiy it - else ambiguous layout.

```swift
    // statusTextView
    statusTextView.topAnchor.constraint(equalTo: profileImageView.bottomAnchor, constant: 4).isActive = true
    statusTextView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 8).isActive = true
    statusTextView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 8).isActive = true
	 statusTextView.heightAnchor.constraint(equalToConstant: 30).isActive = true
```

// bottom anchor status view
### Links that help
* [Build that App](https://www.youtube.com/watch?v=NJxb7EKXF3U)
