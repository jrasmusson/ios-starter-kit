# Basic Animation Curves

This demo shows how to animate positions and opacity vertically using basic animation curve.

![Demo](https://github.com/jrasmusson/ios-starter-kit/blob/master/animations/BasicAnimationCurves/images/demo.gif)

```swift
//
//  ViewController.swift
//  BasicAnimationCurves
//
//  Created by Jonathan Rasmusson (Contractor) on 2018-09-18.
//  Copyright © 2018 Jonathan Rasmusson (Contractor). All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Your title"
        label.textAlignment = .center
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 28)

        return label
    }()

    let bodyLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua."
        label.textColor = .gray
        label.textAlignment = .center
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.font = UIFont.systemFont(ofSize: 14)

        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()
    }

    // Step 1: Hide the elements we want to animate onto the screen
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        self.titleLabel.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 100).isActive = true
        self.titleLabel.alpha = 0.33

        bodyLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 12).isActive = true
        self.bodyLabel.alpha = 0.33
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        // Animate in title
        UIView.animate(withDuration: 4.0) {
            self.titleLabel.transform = self.titleLabel.transform.translatedBy(x: 0, y: -50)
        }

        UIView.animate(withDuration: 3.3) {
            self.titleLabel.alpha = 1
        }

        UIView.animate(withDuration: 3.7, delay: 0.3, options: .curveEaseOut, animations: {
            self.bodyLabel.transform = self.bodyLabel.transform.translatedBy(x: 0, y: -50)
        }, completion: nil)

        UIView.animate(withDuration: 3) {
            self.bodyLabel.alpha = 1
        }

    }

    func setupViews() {

        // animation
        view.addSubview(titleLabel)
        view.addSubview(bodyLabel)

        // Trick with animations is to do your final layout first - set the constraints the way you want them to end up.
        // Then move them to `viewWillAppear` along with any deltas you want in `viewDidAppear`.

//        titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 100).isActive = true
        titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true

//        bodyLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 12).isActive = true
        bodyLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24).isActive = true
        bodyLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24).isActive = true
    }
}

```



### Links that help
* [Curve Visualizations](https://medium.com/@RobertGummesson/a-look-at-uiview-animation-curves-part-1-191d9e6de0ab)
