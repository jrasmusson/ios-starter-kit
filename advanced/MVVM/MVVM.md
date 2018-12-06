# MVVM

MVVM is a variation of MVC where we pull presentation and business logic out of of `ViewController` and stick it in something called a `ViewModel`

MVVC

![mvc](https://github.com/jrasmusson/ios-starter-kit/blob/master/advanced/MVVM/images/mvc.png)

MVVM

![mvvm](https://github.com/jrasmusson/ios-starter-kit/blob/master/advanced/MVVM/images/mvvm.png)

The advantage of doing this is

* smaller `ViewControllers`
* easier more testable coding units

## Example

Here is a simple example that shows how we can pull the presentation logic for some labels, out into a `PersonViewmodel` and then use that in the `ViewController` instead of embedding the presentation logic right in there.

```swift
//
//  ViewController.swift
//  MVVM Basic
//
//  Created by Jonathan Rasmusson Work Pro on 2018-07-28.
//  Copyright © 2018 Rasmusson Software Consulting. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var label: UILabel!
    @IBOutlet var button: UIButton!
    @IBOutlet var onOffSwitch: UISwitch!
    
    var viewModel: PersonViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let person = Person(salutation: "Mr", firstName: "Jonathan", lastName: "Smith")
        viewModel = PersonViewModel(person: person, button: button, onOffSwitch: onOffSwitch)

        // Extract business logic like this
        label.text = viewModel.nameText
    }
    
    @IBAction func buttonPressed(_ sender: UIButton) {
        
        // And presentation logic like this
        viewModel.registerPerson()
    }
}
```

```swift
//
//  Person.swift
//  MVVM Basic
//
//  Created by Jonathan Rasmusson Work Pro on 2018-07-28.
//  Copyright © 2018 Rasmusson Software Consulting. All rights reserved.
//

import Foundation

struct Person {
    var salutation: String
    var firstName: String
    var lastName: String
}
```

```swift
//
//  PersonViewModel.swift
//  MVVM Basic
//
//  Created by Jonathan Rasmusson Work Pro on 2018-07-28.
//  Copyright © 2018 Rasmusson Software Consulting. All rights reserved.
//

import Foundation
import UIKit

struct PersonViewModel {
    
    var person: Person
    var button: UIButton
    var onOffSwitch: UISwitch

    // Business logic that would normally be in our `ViewController`
    var nameText: String {
        
        if person.salutation.count > 0 {
            return person.salutation + " " + person.firstName + " " + person.lastName
        }
        
        return person.firstName + " " + person.lastName
    }
    
    // Presentation logic that would normally be in our `ViewController`
    func registerPerson() {
        onOffSwitch.isOn = !onOffSwitch.isOn
    }
}
```

## Tests

Now instead of having to instantiate a `ViewController` and invoke methods directly in it we can easier test our business logic more directly against plain-old Swift objects.

```swift
//
//  MVVM_BasicTests.swift
//  MVVM BasicTests
//
//  Created by Jonathan Rasmusson Work Pro on 2018-07-28.
//  Copyright © 2018 Rasmusson Software Consulting. All rights reserved.
//

import XCTest
@testable import MVVM_Basic

class MVVM_BasicTests: XCTestCase {

    var button: UIButton!
    var onOffSwitch: UISwitch!

    var viewModel: PersonViewModel!
    var person: Person!
    
    override func setUp() {
        super.setUp()
        
        button = UIButton()
        onOffSwitch = UISwitch()
        
        person = Person(salutation: "Mr", firstName: "Jonathan", lastName: "Smith")
        viewModel = PersonViewModel(person: person, button: button, onOffSwitch: onOffSwitch)
    }

    func testBusinessLogic() {
        XCTAssertEqual("Mr Jonathan Smith", viewModel.nameText)
    }

    func testPresentationLogic() {
        onOffSwitch.isOn = false
        viewModel.registerPerson()
        XCTAssertTrue(onOffSwitch.isOn)
    }

}
```



![demo](https://github.com/jrasmusson/ios-starter-kit/blob/master/advanced/MVVM/images/demo.gif)

### Links that help
* None yet
