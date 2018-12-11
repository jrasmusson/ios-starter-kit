# How to support different device sizes

<img src="https://github.com/jrasmusson/ios-starter-kit/blob/master/autolayout/images/how-to-layout-different-device-sizes/different-device-sizes.png" />

To do layout of different device sizes do the following:

1. Start your layout pinned to the bottom.

<img src="https://github.com/jrasmusson/ios-starter-kit/blob/master/autolayout/images/how-to-layout-different-device-sizes/pin-to-bottom-a.png" />

2. The create a container container the hero image you want displayed in the middle of the layout.

<img src="https://github.com/jrasmusson/ios-starter-kit/blob/master/autolayout/images/how-to-layout-different-device-sizes/container.png" />

Set the imageView to

```swift
imageView.contentMode = .scaleAspectFit
```

Then set the constraints on the imageView to fill the available container. This works because we are telling the imageView to keep it's aspect ratio, while resizing itself to view the container. This will let the image grow to fill the space as necessary.

So create the imageView and add it to the container.

```swift
let heroImageView = makeImageView(named: "activation_intro")
        
let containerView = UIView()
containerView.translatesAutoresizingMaskIntoConstraints = false
containerView.addSubview(heroImageView)

view.addSubview(containerView)
```

Have the imageView fill the container.

```swift
heroImageView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 8).isActive = true
heroImageView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -8).isActive = true
heroImageView.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: 8).isActive = true
heroImageView.rightAnchor.constraint(equalTo: containerView.rightAnchor, constant: -8).isActive = true
```

Then layout the container tying it to the bottom elements of the page.

```swift
containerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8).isActive = true
containerView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 8).isActive = true
containerView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -8).isActive = true
containerView.bottomAnchor.constraint(equalTo: heroLabel.topAnchor, constant: 8).isActive = true
```

Now this almost works. But we aren't out of the woods yet. If we run this right now we will get ambigous height violations because the imageView doesn't have a defined height. Autolayout doesn't know how high to make it, and it those everything off.

To fix, lower it's vertical hugging and compression resistance.

```swift
heroImageView.setContentHuggingPriority(UILayoutPriority(rawValue: 249), for: .vertical);
heroImageView.setContentCompressionResistancePriority(UILayoutPriority(rawValue: 749), for: .vertical)
```

If you follow this link [here](https://developer.apple.com/library/archive/documentation/UserExperience/Conceptual/AutolayoutPG/LayoutUsingStackViews.html), you will see this explaination of how this works from a stackView example.

<img src="https://github.com/jrasmusson/ios-starter-kit/blob/master/autolayout/images/how-to-layout-different-device-sizes/compression-apple-docs.png" />


### Links that help

* [Apple Human Interface Guide](https://developer.apple.com/design/human-interface-guidelines/ios/visual-design/adaptivity-and-layout/)
