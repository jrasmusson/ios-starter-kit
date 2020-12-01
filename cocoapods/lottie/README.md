# Lottie

![Demo](https://github.com/jrasmusson/ios-starter-kit/blob/master/cocoapods/lottie/images/demo.gif)


## Setup

```bash
sudo gem install cocoapods
cd <project>
pod init
vi Podfile
- pod 'lottie-ios'
pod install
```
Close Xcode. Reopen project file.

## Importing Lottie files

Lottie files come in as raw json files (do not add to asset catalog).

[Download](https://www.lottiefiles.com/159-servishero-loading) sample lottie file.

Drag into project (not Asset).

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

// Note: All graphics are included in json animation file
//       Also the file name matters. You must use the same json file name when loading.

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let animationView = AnimationView(name: "39784-check-mark")

        animationView.frame = CGRect(x: 0, y: 0, width: 400, height: 400)
        animationView.center = self.view.center
        animationView.contentMode = .scaleAspectFill
        animationView.loopMode = .loop
        animationView.animationSpeed = 0.5

        view.addSubview(animationView)

        animationView.play()
    }
}
```



### Links

- [HelloWorld Lottie](https://www.appcoda.com/lottie-beginner-guide/)
