# UIButton


```swift
    let gotItButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .green
        button.setTitle("GOT IT", for: .normal)
        button.addTarget(self, action: #selector(gotItButtonPressed), for: .touchUpInside)
        button.setTitleColor(.black, for: .normal)

        return button
    }()

    view.addSubview(gotItButton)
	
    gotItButton.widthAnchor.constraint(equalToConstant: 100).isActive = true
    gotItButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
    gotItButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24).isActive = true
    gotItButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 8).isActive = true

    @objc func gotItButtonPressed(sender: UIButton!) {
        print("Button tapped")
    }
```




