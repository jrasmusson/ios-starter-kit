# Centerng and aligning

Here is a good technique for centering and aligning. Hang everything off the activate image and label. The trick with this layout is to pick a base, and then align everything relative to it. You could try this with `UIStackView` but you would have a lot of stackViews. And this way you have full control over everything.

<img src="https://github.com/jrasmusson/ios-starter-kit/blob/master/autolayout/images/centering-and-aligning.png" width="400"  alt="drawing" />


```swift
    func setupViews() {
        view.backgroundColor = .white

        let heroImageView = makeImageView(named: "activation_intro")
        let heroLabel = makeHeroLabel(text: "Let's get you online and connected")

        let setupImageView = makeImageView(named: "setup")
        let activateImageView = makeImageView(named: "activate")
        let connectImageView = makeImageView(named: "connect")

        let setupLabel = makeSubtitleGrayLabel(text: "Set up")
        let activateLabel = makeSubtitleGrayLabel(text: "Activate")
        let connectLabel = makeSubtitleGrayLabel(text: "Connect")

        let chevronLeft = makeImageView(named: "chevron")
        let chevronRight = makeImageView(named: "chevron")

        view.addSubview(heroImageView)
        view.addSubview(heroLabel)

        view.addSubview(setupImageView)
        view.addSubview(activateImageView)
        view.addSubview(connectImageView)

        view.addSubview(setupLabel)
        view.addSubview(activateLabel)
        view.addSubview(connectLabel)

        view.addSubview(chevronLeft)
        view.addSubview(chevronRight)

        view.addSubview(gettingStartedbutton)

        heroImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: -12).isActive = true
        heroImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 32).isActive = true

        heroLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        heroLabel.topAnchor.constraint(equalTo: heroImageView.bottomAnchor, constant: 34).isActive = true
        heroLabel.widthAnchor.constraint(equalToConstant: 300).isActive = true

        activateImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        activateImageView.topAnchor.constraint(equalTo: heroLabel.bottomAnchor, constant: 28).isActive = true

        activateLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        activateLabel.topAnchor.constraint(equalTo: activateImageView.bottomAnchor, constant: 12).isActive = true

        chevronLeft.centerYAnchor.constraint(equalTo: activateLabel.centerYAnchor).isActive = true
        chevronLeft.rightAnchor.constraint(equalTo: activateLabel.leftAnchor, constant: -20).isActive = true

        chevronRight.centerYAnchor.constraint(equalTo: activateLabel.centerYAnchor).isActive = true
        chevronRight.leftAnchor.constraint(equalTo: activateLabel.rightAnchor, constant: 20).isActive = true

        setupLabel.centerYAnchor.constraint(equalTo: activateLabel.centerYAnchor).isActive = true
        setupLabel.rightAnchor.constraint(equalTo: chevronLeft.leftAnchor, constant: -20).isActive = true

        connectLabel.centerYAnchor.constraint(equalTo: activateLabel.centerYAnchor).isActive = true
        connectLabel.leftAnchor.constraint(equalTo: chevronRight.rightAnchor, constant: 20).isActive = true

        setupImageView.centerXAnchor.constraint(equalTo: setupLabel.centerXAnchor).isActive = true
        setupImageView.centerYAnchor.constraint(equalTo: activateImageView.centerYAnchor).isActive = true

        connectImageView.centerXAnchor.constraint(equalTo: connectLabel.centerXAnchor).isActive = true
        connectImageView.centerYAnchor.constraint(equalTo: activateImageView.centerYAnchor).isActive = true

        gettingStartedbutton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        gettingStartedbutton.topAnchor.constraint(equalTo: activateLabel.bottomAnchor, constant: 44).isActive = true
        gettingStartedbutton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        gettingStartedbutton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 24).isActive = true
        gettingStartedbutton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -24).isActive = true
}
```
