# Custom UITableViewCell

## The Short

**CustomCell.swift**

```swift
import UIKit

class CustomCell: UITableViewCell {

    @IBOutlet var firstNameLabel: UILabel!
    @IBOutlet var lastNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

}
```

**ViewController.swift**

```swift
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
```

## The Long

* Create a new UITableViewCell class with xib

![New class](https://github.com/jrasmusson/ios-starter-kit/blob/master/basics/UITableViewCell/custom/images/newclass.png)

* Give it an identifier

![Identifier](https://github.com/jrasmusson/ios-starter-kit/blob/master/basics/UITableViewCell/custom/images/identifier.png)


* Design your cell

![Design Cell](https://github.com/jrasmusson/ios-starter-kit/blob/master/basics/UITableViewCell/custom/images/design.png)

* Create your cell and add the IBOutlets

```swift
import UIKit

class CustomCell: UITableViewCell {

    @IBOutlet var firstNameLabel: UILabel!
    @IBOutlet var lastNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

}
```

* Load xib in ViewController

```swift
    override func viewDidLoad() {

        myTableView.register(UINib(nibName: "CustomCell", bundle: nil), forCellReuseIdentifier: "customCellIdentifier")
    }
```

* Load cell in cellForRowAt

```swift
let cell = tableView.dequeueReusableCell(withIdentifier: "customCellIdentifier", for: indexPath) as! CustomCell
```

* Set the height

```swift
func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 77
    }
```

Voila!

![Voila](https://github.com/jrasmusson/ios-starter-kit/blob/master/basics/UITableViewCell/custom/images/voila.png)