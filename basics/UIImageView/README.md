# UIImageView

## How to tint

```swift
chevronImageView.image = UIImage(named: "chevron")?.withRenderingMode(.alwaysTemplate)
chevronImageView.tintColor = .systemOrange
```

## How to round corner and draw circle around image

```swift
    func setupCircularImageStyle() {
        companyImageView.layer.cornerRadius = companyImageView.frame.width / 2
        companyImageView.clipsToBounds = true
        companyImageView.layer.borderColor = UIColor.darkBlue.cgColor
        companyImageView.layer.borderWidth = 2
    }
```

Or this

```swift
    let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "zuckprofile")
        imageView.layer.cornerRadius = 34
        imageView.layer.masksToBounds = true

        return imageView
    }()
```

<img src="https://github.com/jrasmusson/ios-starter-kit/blob/master/basics/UIImageView/images/rounded.png" alt="drawing" width="600"/>


## How to image shrink / grow

By lowering the hugging and compression vertically on an image you gain allow it to shrink and grow as need to meet constraints.

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



## Basics

`UIImageView` has three `contentMode`s and eight positions you can use to fill space and position your `UIImageView`.

Scaling

- .scaleToFill
- .scaleAspectFill
- .scaleAspectFit
- .clipToBounds


Positioning

- .top
- .bottom
- .left
- .right
- .topLeft
- .topRight
- .bottomLeft
- .bottomRight



## Scaling the view

For example, say we have a 100x100 star and place it within a 200x350 viewable area where is it stretched to fill the available space.

<img src="https://github.com/jrasmusson/ios-starter-kit/blob/master/basics/UIImageView/images/dimensions.png" alt="drawing" width="200"/>

There are three ways we can scale this image.

### .scaleToFill

<img src="https://github.com/jrasmusson/ios-starter-kit/blob/master/basics/UIImageView/images/scaleToFill.png" alt="drawing" width="400"/>


### .scaleAspectFill

<img src="https://github.com/jrasmusson/ios-starter-kit/blob/master/basics/UIImageView/images/scaleAspectFill.png" alt="drawing" width="400"/>

### .scaleAspectFit

<img src="https://github.com/jrasmusson/ios-starter-kit/blob/master/basics/UIImageView/images/scaleAspectFit.png" alt="drawing" width="400"/>


```swift
//
//  ViewController.swift
//  UIImageView
//
//  Created by Jonathan Rasmusson (Contractor) on 2018-09-05.
//  Copyright © 2018 Jonathan Rasmusson (Contractor). All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let myView = StarView(frame: CGRect(x: 0, y: 0, width:200, height:350))

        myView.starImageView.contentMode = .scaleToFill // default
        myView.starImageView.contentMode = .scaleAspectFill
        myView.starImageView.contentMode = .scaleAspectFill

        view.addSubview(myView)
    }

}

public class StarView: UIView {

    public let starImageView: UIImageView

    public override init(frame: CGRect) {
        let starImage = UIImage(named: "star100")
        starImageView = UIImageView(image: starImage)

        super.init(frame: frame)
        addSubview(starImageView)
        backgroundColor = .green
        starImageView.frame = bounds
    }

    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
```


### .clipToBounds

Notice how in `.scaleAspectFill` our star overflowed its boundaries? If we don't want that to happen we can clip it by setting `clipToBounds` on the superview.

```        myView.clipsToBounds = true```

<img src="https://github.com/jrasmusson/ios-starter-kit/blob/master/basics/UIImageView/images/clipToBounds.png" alt="drawing" width="400"/>

To see that we need to set the allowable view area to 50x50 and insert the star 100x100 thereby overflowing the allowable view area.

```swift
//
//  ViewController.swift
//  UIImageView
//
//  Created by Jonathan Rasmusson (Contractor) on 2018-09-05.
//  Copyright © 2018 Jonathan Rasmusson (Contractor). All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // clip to bounds example
        let myView = StarView(frame: CGRect(x: 0, y: 0, width:50, height:50))

        myView.clipsToBounds = true

        view.addSubview(myView)

    }


}

public class StarView: UIView {

    public let starImageView: UIImageView

    public override init(frame: CGRect) {
        let starImage = UIImage(named: "star100")
        starImageView = UIImageView(image: starImage)

        super.init(frame: frame)
        addSubview(starImageView)
        backgroundColor = .green
//        starImageView.frame = bounds
    }

    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
```

## Positioning the view

The `contentMode` can also be used to position the `UIImageView` into various places within the containing super view. 

> Note: When you do this, the contents of the view are not stretched or scaled in anyway.

<img src="https://github.com/jrasmusson/ios-starter-kit/blob/master/basics/UIImageView/images/top.png" alt="drawing" width="400"/>

<img src="https://github.com/jrasmusson/ios-starter-kit/blob/master/basics/UIImageView/images/left.png" alt="drawing" width="400"/>


### Links that help

* [Apple docs](https://developer.apple.com/documentation/uikit/uiimageview)
* [Use your loaf](https://useyourloaf.com/blog/stretching-redrawing-and-positioning-with-contentmode/)
* [Examples](https://github.com/kharrison/CodeExamples)

