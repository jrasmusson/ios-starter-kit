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
