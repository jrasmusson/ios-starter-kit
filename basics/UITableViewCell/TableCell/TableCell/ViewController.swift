//
//  ViewController.swift
//  TableCell
//
//  Created by Jonathan Rasmusson Work Pro on 2018-07-17.
//  Copyright © 2018 Rasmusson Software Consulting. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var myTableView: UITableView!
    
    let firstNames = ["Peter", "Paul", "Mary"]
    let lastNames = ["Smith", "Jones", "Johnson"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        myTableView.delegate = self
        myTableView.dataSource = self

        myTableView.register(UINib(nibName: "CustomCell", bundle: nil), forCellReuseIdentifier: "customCellIdentifier")
    }
    
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return firstNames.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "customCellIdentifier", for: indexPath) as! CustomCell
        
        cell.firstNameLabel.text = firstNames[indexPath.row]
        cell.lastNameLabel.text = lastNames[indexPath.row]
        
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 77
    }
}
