# Basic Animation

![Demo](https://github.com/jrasmusson/ios-starter-kit/blob/master/animations/BasicAnimation/images/demo.gif)

```swift
//
//  ViewController.swift
//  BasicAnimation
//
//  Created by Jonathan Rasmusson Work Pro on 2018-08-12.
//  Copyright © 2018 Rasmusson Software Consulting. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var heading: UILabel!
    @IBOutlet var username: UITextField!
    @IBOutlet var password: UITextField!
    @IBOutlet var loginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loginButton.clipsToBounds = true
        loginButton.layer.cornerRadius = 20
    }

    // Step 1: Hide the elements we want to animate onto the screen
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        heading.center.x  -= view.bounds.width
        username.center.x -= view.bounds.width
        password.center.x -= view.bounds.width
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        // Step 2: Animate the elements in
        UIView.animate(withDuration: 1.0) {
            self.heading.center.x += self.view.bounds.width
        }
        
        UIView.animate(withDuration: 1.0, delay: 0.3,
                       options: [],
                       animations: {
                        self.username.center.x += self.view.bounds.width
        },
                       completion: nil
        )
        
        UIView.animate(withDuration: 1.0, delay: 0.4,
                       options: [],
                       animations: {
                        self.password.center.x += self.view.bounds.width
        },
                       completion: nil
        )    }
}
```



### Links that help
* [Tutorial](https://www.raywenderlich.com/363-ios-animation-tutorial-getting-started)
