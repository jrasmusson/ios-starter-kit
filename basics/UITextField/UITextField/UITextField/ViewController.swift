//
//  ViewController.swift
//  UITextField
//
//  Created by Jonathan Rasmusson Work Pro on 2018-07-21.
//  Copyright © 2018 Rasmusson Software Consulting. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var textField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // dismiss keyboard via tap gesture
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(viewTapped))
        view.addGestureRecognizer(tapGesture)
    }

    @objc func viewTapped() {
        view.endEditing(true)
    }
    
    // or by giving up first responder
    @IBAction func buttonPressed(_ sender: UIButton) {
        textField.resignFirstResponder()
    }
    
    // Note: `view.endEditing(true)` scans entire view until if finds first responder to resign
    //       `textField.resignFirstResponder()` is a more direct call to the textfield itself
}

