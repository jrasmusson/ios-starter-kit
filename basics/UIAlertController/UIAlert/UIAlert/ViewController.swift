//
//  ViewController.swift
//  UIAlert
//
//  Created by Jonathan Rasmusson Work Pro on 2018-07-18.
//  Copyright © 2018 Rasmusson Software Consulting. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func buttonPressed(_ sender: UIButton) {
        
        var alert: UIAlertController! = nil
        
        if sender.titleLabel?.text == "Alert" {
           alert = UIAlertController(title: "Title", message: "Simple message", preferredStyle: .alert)
        } else {
           alert = UIAlertController(title: "Title", message: "Simple message", preferredStyle: .actionSheet)
        }
        
        let defaultAction = UIAlertAction(title: "Default", style: .default) { (action:UIAlertAction) in
            // nop
        }
        
        let destructiveAction = UIAlertAction(title: "Destructive", style: .destructive) { (action:UIAlertAction) in
            // nop
        }

        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (action:UIAlertAction) in
            // nop
        }
        
        alert.addAction(defaultAction)
        alert.addAction(destructiveAction)
        alert.addAction(cancelAction)
        
        present(alert, animated: true, completion: nil)
    }
    
    @IBAction func customButtonPressed(_ sender: UIButton) {
        // Can add text fields to alerts
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New Category", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add", style: .default) { (action) in
            
            let newCategory = Category()
            newCategory.name = textField.text!
            
            // save results
        }
        
        alert.addAction(action)
        
        alert.addTextField { (field) in
            textField = field
            textField.placeholder = "Add a new category"
        }
        
        present(alert, animated: true, completion: nil)
    }
    
    private class Category {
        var name: String = ""
    }
}

