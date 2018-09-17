# Lottie

![Demo](https://github.com/jrasmusson/ios-starter-kit/blob/master/cocoapods/Lottie/images/demo.gif)

## Setup

```bash
sudo gem install cocoapods
cd <project>
pod init
vi Podfile
pod install
```
Close Xcode. Reopen project file.

[Download](https://www.lottiefiles.com/159-servishero-loading) sample lottie file.

Drag into project.

```swift
//
//  ViewController.swift
//  LottieExample
//
//  Created by Jonathan Rasmusson (Contractor) on 2018-09-17.
//  Copyright © 2018 Jonathan Rasmusson (Contractor). All rights reserved.
//

import UIKit
import Lottie

// Note: All graphiucs are included in json animation file

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let animationView = LOTAnimationView(name: "servishero_loading")

        animationView.frame = CGRect(x: 0, y: 0, width: 400, height: 400)
        animationView.center = self.view.center
        animationView.contentMode = .scaleAspectFill
        animationView.loopAnimation = true
        animationView.animationSpeed = 0.5

        view.addSubview(animationView)

        animationView.play()
    }
}
```



### Links

- [HelloWorld Lottie](https://www.appcoda.com/lottie-beginner-guide/)
