# How to support different device sizes

<img src="https://github.com/jrasmusson/ios-starter-kit/blob/master/autolayout/images/how-to-layout-different-device-sizes/different-device-sizes.png" />

To do layout of different device sizes do the following:

1. Start your layout pinned to the bottom.

<img src="https://github.com/jrasmusson/ios-starter-kit/blob/master/autolayout/images/how-to-layout-different-device-sizes/pin-to-bottom-a.png" />

2. The create a container container the hero image you want displayed in the middle of the layout.

<img src="https://github.com/jrasmusson/ios-starter-kit/blob/master/autolayout/images/how-to-layout-different-device-sizes/container.png" />

This will let the hero image expand as necessary to fill the space, and be based on the intrinsic size of the image itself.

So simply create an heroView and add it to your container

```swift
let heroImageView = makeImageView(named: "activation_intro")
        
let containerView = UIView()
containerView.translatesAutoresizingMaskIntoConstraints = false
containerView.addSubview(heroImageView)

view.addSubview(containerView)
```

Then center and make it expand to left/right edges.

```swift
heroImageView.centerXAnchor.constraint(equalTo: containerView.centerXAnchor).isActive = true
heroImageView.centerYAnchor.constraint(equalTo: containerView.centerYAnchor).isActive = true
heroImageView.leftAnchor.constraint(equalTo: containerView.leftAnchor).isActive = true
heroImageView.rightAnchor.constraint(equalTo: containerView.rightAnchor).isActive = true
```

Then make the container expand to the top, left, right, and bottom elements.

```swift
        containerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8).isActive = true
        containerView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 8).isActive = true
        containerView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -8).isActive = true
        containerView.bottomAnchor.constraint(equalTo: heroLabel.topAnchor, constant: 8).isActive = true
```


### Links that help

* [Apple Human Interface Guide](https://developer.apple.com/design/human-interface-guidelines/ios/visual-design/adaptivity-and-layout/)
