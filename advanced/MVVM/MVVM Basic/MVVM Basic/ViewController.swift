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

