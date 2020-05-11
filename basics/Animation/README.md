# Animations

## Animating the alpha

Here are two ways you can animate some controls when a user taps a `UITableView` row.

![](images/games-demo.gif)

```swift
UIView.animate(withDuration: 3) {
    self.profileImage.image = UIImage(named: game.imageName)
    self.titleLabel.text = game.name
    self.bodyLabel.text = game.description

    self.profileImage.alpha = 1
    self.titleLabel.alpha = 1
    self.bodyLabel.alpha = 1

    self.view.layoutIfNeeded()
}

UIViewPropertyAnimator.runningPropertyAnimator(withDuration: 3, delay: 0, options: [], animations: {
    self.profileImage.image = UIImage(named: game.imageName)
    self.titleLabel.text = game.name
    self.bodyLabel.text = game.description

    self.profileImage.alpha = 1
    self.titleLabel.alpha = 1
    self.bodyLabel.alpha = 1
})
```

### Links that help

- [Quick Guide To Property Animators](https://useyourloaf.com/blog/quick-guide-to-property-animators/)