# Basics

## The trick to using baselines

The baseline constraint only works if you leave the label and text field alone, and don't try to set them yourself.

```swift

view.addSubview(nameLabel)
view.addSubview(nameTextField)

nameLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 8).isActive = true
nameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
nameLabel.widthAnchor.constraint(equalToConstant: 50).isActive = true
//        nameLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true

nameTextField.leadingAnchor.constraint(equalTo: nameLabel.trailingAnchor, constant: 8).isActive = true
nameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
nameLabel.lastBaselineAnchor.constraint(equalTo: nameTextField.lastBaselineAnchor, constant: 0).isActive = true
```

<img src="https://github.com/jrasmusson/ios-starter-kit/blob/master/autolayout/images/baseline.png" alt="drawing" width="300"/>

<img src="https://github.com/jrasmusson/ios-starter-kit/blob/master/autolayout/images/baseline2.png" alt="drawing" width="800"/>

[Apple Docs](https://developer.apple.com/library/archive/documentation/UserExperience/Conceptual/AutolayoutPG/ViewswithIntrinsicContentSize.html#//apple_ref/doc/uid/TP40010853-CH13-SW1)
