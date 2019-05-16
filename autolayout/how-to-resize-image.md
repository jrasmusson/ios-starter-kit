# Different ways to resize an image


When it comes to autolaying out images, there are a couple of different routes you can take.

## Make the image flex with hugging and compression

One way is to embed the image within another view, set the image to `scaleAspectFit` to drop the hugging and compression so that the image contracts and expands to fill the entire area. 

<img src="https://github.com/jrasmusson/ios-starter-kit/blob/master/autolayout/images/shrink.png" width="800px" />

```swift        
public static func makeImageView(named: String) -> UIImageView {
let imageView = UIImageView()
imageView.translatesAutoresizingMaskIntoConstraints = false
imageView.contentMode = .scaleAspectFit
imageView.image = UIImage(named: named)

// shrink and grow
imageView.setContentHuggingPriority(UILayoutPriority(rawValue: 249), for: .vertical)
imageView.setContentCompressionResistancePriority(UILayoutPriority(rawValue: 749), for: .vertical)

return imageView
}
```

And then lay it out like any other view. 

## Crop the image with scaleAspectFill

<img src="https://github.com/jrasmusson/ios-starter-kit/blob/master/autolayout/images/crop.png" width="800px" />

Another technique you can use is to create a regular `UIImage` with `.scaleAspectFill` and `clipsToBounds` (optional).

```swift
    backgroundImageView.image = #imageLiteral(resourceName: "BackgroundImage")
    backgroundImageView.contentMode = .scaleAspectFill
    backgroundImageView.clipsToBounds = true
    backgroundImageView.translatesAutoresizingMaskIntoConstraints = false
```

And then lay it out as usual

```swift
    backgroundImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
    backgroundImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
    backgroundImageView.topAnchor.constraint(equalTo: topAnchor),
```

This will then crop the image appropriately, while maintaining the aspect ratio to fit the available space.

X 5s

This lets you layout your bottom controls as normal. And then have the image crop to whatever size it needs to be.

