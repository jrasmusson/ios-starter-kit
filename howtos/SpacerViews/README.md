# Spacer Views

This receipe shows you how to use the `UILayoutGuide` to create spacer views between UI elements. This is better than creating dummy views as it it more performant.

The red dotted lines are empty spacer views that are there purely for spacing the other UI elements. 

Note also that there is an extension at the bottom that enables the red dotted spacers to show up.

<img src="https://github.com/jrasmusson/ios-starter-kit/blob/master/howtos/SpacerViews/images/demo.png" alt="drawing" width="400"/>

```swift
//
//  ViewController.swift
//  SpaceViews
//
//  Created by Jonathan Rasmusson (Contractor) on 2018-09-11.
//  Copyright © 2018 Jonathan Rasmusson (Contractor). All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()
    }

    func setupViews() {

        let redView = UIView()
        redView.translatesAutoresizingMaskIntoConstraints = false
        redView.backgroundColor = .red

        view.addSubview(redView)

        redView.topAnchor.constraint(equalTo: view.topAnchor, constant: 20).isActive = true
        redView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        redView.widthAnchor.constraint(equalToConstant: 300).isActive = true
        redView.heightAnchor.constraint(equalToConstant: 300).isActive = true

        let greenView = UIView()
        greenView.translatesAutoresizingMaskIntoConstraints = false
        greenView.backgroundColor = .green

        view.addSubview(greenView)

        greenView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        greenView.widthAnchor.constraint(equalToConstant: 50).isActive = true
        greenView.heightAnchor.constraint(equalToConstant: 50).isActive = true

        let blueView = UIView()
        blueView.translatesAutoresizingMaskIntoConstraints = false
        blueView.backgroundColor = .blue

        view.addSubview(blueView)

        blueView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        blueView.widthAnchor.constraint(equalToConstant: 200).isActive = true
        blueView.heightAnchor.constraint(equalToConstant: 200).isActive = true

        // spacers
        let space1 = UILayoutGuide()
        view.addLayoutGuide(space1)

        let space2 = UILayoutGuide()
        view.addLayoutGuide(space2)

        space1.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        space2.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true

        space1.widthAnchor.constraint(equalToConstant: 100).isActive = true
        space2.widthAnchor.constraint(equalTo: space1.widthAnchor).isActive = true

        space1.heightAnchor.constraint(equalToConstant: 100).isActive = true
        space2.heightAnchor.constraint(equalTo: space1.heightAnchor).isActive = true

        space1.widthAnchor.constraint(equalTo: space2.widthAnchor).isActive = true
        redView.bottomAnchor.constraint(equalTo: space1.topAnchor).isActive = true
        greenView.topAnchor.constraint(equalTo: space1.bottomAnchor).isActive = true
        greenView.bottomAnchor.constraint(equalTo: space2.topAnchor).isActive = true
        blueView.topAnchor.constraint(equalTo: space2.bottomAnchor).isActive = true

    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.view.showLayoutGuides()
    }
}

//
// Helper
//
extension UIView {

    func showLayoutGuides() {

        #if DEBUG
        for sub in subviews {
            sub.showLayoutGuides()
        }

        guard let layoutGuides = self.layer.sublayers else {
            return
        }

        // Clear previous layers
        for layer in layoutGuides {
            if layer is LayoutGuideLayer {
                layer.removeFromSuperlayer()
            }
        }

        // Add new layers for guides
        for guide in self.layoutGuides {
            let layoutGuideLayer = LayoutGuideLayer(guide: guide)
            self.layer.addSublayer(layoutGuideLayer)
        }

        #endif
    }

}

class LayoutGuideLayer: CAShapeLayer {

    init(guide:UILayoutGuide) {
        super.init()

        self.path = UIBezierPath(rect: guide.layoutFrame).cgPath
        self.lineWidth = 0.5
        self.lineDashPattern = [1, 1, 1, 1]
        self.fillColor = UIColor.clear.cgColor
        self.strokeColor = UIColor.red.cgColor
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
```


### Links that help

* [Apple UILayoutGuide](https://developer.apple.com/documentation/uikit/uilayoutguide)

