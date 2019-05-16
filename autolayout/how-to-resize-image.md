# Different ways to resize an image


When it comes to autolaying out images, there are a couple of different routes you can take.

## Make the image flex with hugging and compression

One way is to embed the image within another view, set the image to `scaleAspectFit` to drop the hugging and compression so that the image contracts and expands to fill the entire area. 

<img src="https://github.com/jrasmusson/ios-starter-kit/blob/master/autolayout/images/embedded-view.png" />

```swift        
    public static func makeImageView(named: String) -> UIImageView {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: named)

        return imageView
    }
    
    public class HeroView: UIView {

    typealias Factory = ControlFactory

    init(frame: CGRect, named: String) {
        super.init(frame: frame)

        let heroImageView = Factory.makeImageView(named: named)

        addSubview(heroImageView)

        heroImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 0).isActive = true
        heroImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0).isActive = true
        heroImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0).isActive = true
        heroImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0).isActive = true

        heroImageView.setContentHuggingPriority(UILayoutPriority(rawValue: 249), for: .vertical)
        heroImageView.setContentCompressionResistancePriority(UILayoutPriority(rawValue: 749), for: .vertical)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
```

And then lay it out like any other view.


```swift
	Factory.makeHeroView(named: "XB6_waves_tighter")
	
    heroView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0).isActive = true
    heroView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 0).isActive = true
    heroView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: 0).isActive = true
```

Use this method when you want the image to shrink and grow to the space available.

## Crop the image with scaleAspectFill

<img src="https://github.com/jrasmusson/ios-starter-kit/blob/master/autolayout/images/crop-image.png" width="800px" />

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

