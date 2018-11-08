# How to key value observe

This example shows how you can observe register to observe a value on an object (`hasWifi`) and then be notified when it changes.

```swift
//
//  ViewController.swift
//  SwiftKVO
//
//  Created by Jonathan Rasmusson on 2018-11-08.
//  Copyright © 2018 Jonathan Rasmusson. All rights reserved.
//

import UIKit

class Repository: NSObject {

    let service = Service()

    // 1 Make hasWifi observable
    @objc dynamic var hasWifi = false

    func load() {
        service.fetchHasWifi { (hasWifi, error) in
            // 4 Change value
            self.hasWifi = hasWifi ?? false
        }
    }
}

struct Service {

    func fetchHasWifi(completion: @escaping (Bool?, Error?) -> ()) {
        let hasWifi = true
        completion(hasWifi, nil)
    }

}

class ViewController: UIViewController {

    @objc let repository = Repository()

    var observation: Any?

    override func viewDidLoad() {
        super.viewDidLoad()

        // 2 Register to observe
        observation = repository.observe(\.hasWifi, options: [.initial, .new]) {
            // 5 Get updated
            [unowned self] object, change in
            let boolVal = change.newValue
            print("hasWifi: \(String(describing: boolVal))")
        }

        // 3 Refresh
        repository.load()
    }

}
```
