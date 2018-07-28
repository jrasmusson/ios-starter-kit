# MVVM

MVVM is a variation of MVC where we pull presentation and business logic out of of `ViewController` and stick it in something called a `ViewModel`

MVVC

![mvc](https://github.com/jrasmusson/ios-starter-kit/blob/master/basics/MVVM/images/mvc.png)

MVVM

![mvvm](https://github.com/jrasmusson/ios-starter-kit/blob/master/basics/MVVM/images/mvvm.png)

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

    @IBOutlet var label1: UILabel!
    @IBOutlet var label2: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let person1 = Person(salutation: "Mr", firstName: "Jonathan", lastName: "Smith")
        let person2 = Person(salutation: "", firstName: "Tom", lastName: "Jones")
        
        let viewModel1 = PersonViewModel(person: person1)
        let viewModel2 = PersonViewModel(person: person2)
        
        label1.text = viewModel1.nameText
        label2.text = viewModel2.nameText
    }
    
    // By moving this method into our `PersonViewModel` things get a lot easier.
    //  - easier to test
    //  - smaller `ViewController`
    
    /*
    func nameText(for person:Person) {
    
        if person.salutation.count > 0 {
            return person.salutation + " " + person.firstName + " " + person.lastName
        }
        
        return person.firstName + " " + person.lastName
    }
    */

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

struct PersonViewModel {
    var person: Person
    
    // Business logic that would normally be in our `ViewController`
    var nameText: String {
        
        if person.salutation.count > 0 {
            return person.salutation + " " + person.firstName + " " + person.lastName
        }
        
        return person.firstName + " " + person.lastName
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
    
    func testSaluationNameText() {
        let person = Person(salutation: "Mr", firstName: "Jonathan", lastName: "Smith")
        let viewModel = PersonViewModel(person: person)
        
        XCTAssertEqual("Mr Jonathan Smith", viewModel.nameText)
    }

    func testNoSaluationNameText() {
        let person = Person(salutation: "", firstName: "Jonathan", lastName: "Smith")
        let viewModel = PersonViewModel(person: person)
        
        XCTAssertEqual("Jonathan Smith", viewModel.nameText)
    }

}
```



![demo](https://github.com/jrasmusson/ios-starter-kit/blob/master/basics/MVVM/images/demo.png)

### Links that help
* None yet
