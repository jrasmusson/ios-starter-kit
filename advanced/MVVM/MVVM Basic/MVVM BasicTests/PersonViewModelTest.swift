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
