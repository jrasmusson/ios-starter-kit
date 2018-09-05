# UIImageView

`UIImageView` has several `contentMode`s you can use to describe how the image will fill the available space assigned to it.

For example, say we create a green background view like this, and place into it a star with the following dimensions.

<img src="https://github.com/jrasmusson/ios-starter-kit/blob/master/basics/UIImageView/images/dimensions.png" alt="drawing" width="200"/>

By adding the star to the greenbackGround, and expanding it to fill the full 200x350 frame, here are three ways we can scale this image.

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

## Scaling the view

### .scaleToFill

<img src="https://github.com/jrasmusson/ios-starter-kit/blob/master/basics/UIImageView/images/scaleToFill.png" alt="drawing" width="200"/>


### .scaleAspectFill

<img src="https://github.com/jrasmusson/ios-starter-kit/blob/master/basics/UIImageView/images/scaleAspectFill.png" alt="drawing" width="200"/>

### .scaleAspectFit

<img src="https://github.com/jrasmusson/ios-starter-kit/blob/master/basics/UIImageView/images/scaleAspectFit.png" alt="drawing" width="200"/>


### .clipToBounds

![TableView](https://github.com/jrasmusson/ios-starter-kit/blob/master/basics/UIImageView/images/clipToBounds.png)

If the image spills over the allowable view area, and we don't want to see it, we can set `clipToBounds` on the super view and it will cut the extra image off.

Here we set the allowable view area to 50x50 and insert the star 100x100 thereby overflowing the allowable view area.

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

- .top
- .bottom
- .left
- .right


- .topLeft
- .topRight
- .bottomLeft
- .bottomRight


### Links that help

* [Apple docs](https://developer.apple.com/documentation/uikit/uiimageview)
* [Use your loaf](https://useyourloaf.com/blog/stretching-redrawing-and-positioning-with-contentmode/)
* [Use your loaf repos](https://github.com/kharrison/CodeExamples)


![TableView](https://github.com/jrasmusson/ios-starter-kit/blob/master/basics/UIImageView/images/dimensions.png)
