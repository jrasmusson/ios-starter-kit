# How to circles

## Solid circle

```swift
func makeOrangeDot() -> UIView {
    let view = UIView.init(frame: CGRect(x: 0, y: 0, width: radius*2, height: radius*2))
    view.translatesAutoresizingMaskIntoConstraints = false
    view.layer.borderColor = UIColor.orange.cgColor
    view.layer.backgroundColor = UIColor.orange.cgColor
    view.layer.cornerRadius = radius
    view.layer.borderWidth = 0.5

    return view
}
```
<img src="https://github.com/jrasmusson/ios-starter-kit/blob/master/howtos/images/orange-circle.png" />

## Circle with image

You could get your artist to cut the image so that is has an image around it, but you can also draw your own circle around an image. You just need to set the constraints on the image inside the subimage, and obviously the circle itself.

<img src="https://github.com/jrasmusson/ios-starter-kit/blob/master/howtos/images/circle-around-image.png" />


```swift
    func setupViews() {
        view.backgroundColor = .white

        let radius: CGFloat = 35
        let circleView = UIView.init(frame: CGRect(x: 0, y: 0, width: radius*2, height: radius*2))
        circleView.translatesAutoresizingMaskIntoConstraints = false
        circleView.layer.borderColor = UIColor.lightGray.cgColor
        circleView.layer.cornerRadius = radius
        circleView.layer.borderWidth = 0.5

        let setupImageView = makeImageView(named: "setup")

        circleView.addSubview(setupImageView)

        view.addSubview(circleView)

        setupImageView.centerXAnchor.constraint(equalTo: circleView.centerXAnchor).isActive = true
        setupImageView.centerYAnchor.constraint(equalTo: circleView.centerYAnchor).isActive = true

        circleView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        circleView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 32).isActive = true
        circleView.widthAnchor.constraint(equalToConstant: 70).isActive = true
        circleView.heightAnchor.constraint(equalToConstant: 70).isActive = true
    }

```


