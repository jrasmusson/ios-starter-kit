# UISwitch

```swift
//
//  ViewController.swift
//  FooSwitch
//
//  Created by Jonathan Rasmusson (Contractor) on 2018-11-06.
//  Copyright © 2018 Jonathan Rasmusson (Contractor). All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let aSwitch: UISwitch = {
        let theSwitch = UISwitch()
        theSwitch.translatesAutoresizingMaskIntoConstraints = false
        theSwitch.isOn = true
        theSwitch.isEnabled = true
        return theSwitch
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        view.addSubview(aSwitch)

        aSwitch.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        aSwitch.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
}
```

<img src="https://github.com/jrasmusson/ios-starter-kit/blob/master/basics/UISwitch/images/example.png" alt="drawing"/>


