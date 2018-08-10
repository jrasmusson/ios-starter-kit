# NSUserDefaults

`NSUserDefaults` are temporary local storage you can use for storing data on the user's device.


```swift
//
//  ViewController.swift
//  UserDefaults
//
//  Created by Jonathan Rasmusson Work Pro on 2018-08-10.
//  Copyright © 2018 Rasmusson Software Consulting. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var array: [String]?
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let items = defaults.array(forKey: "Array") as? [String] {
            array = items
        }
        
        defaults.set(array, forKey: "Array")

        // NSUserDefauls are stored in plist files that you can see here
        print(NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).last! as String)
    }

}

```


### Links that help
* [Apple Docs](https://developer.apple.com/documentation/foundation/nsuserdefaults)
