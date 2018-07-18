# How to setup a UITableView

## The Short
```swift
import UIKit

class ViewController: UIViewController {

    @IBOutlet var myTableView: UITableView!
    
    let cities = ["New York", "London", "San Francisco"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        myTableView.delegate = self
        myTableView.dataSource = self
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cities.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath)
        cell.textLabel?.text = cities[indexPath.row]
        return cell
    }
}
```

## The Long

Add a TableView to your UIViewController.

![TableView](https://github.com/jrasmusson/ios-starter-kit/blob/master/basics/UITableView/images/blank-vc.png)


Add a Table View Cell to the table.

![TableView](https://github.com/jrasmusson/ios-starter-kit/blob/master/basics/UITableView/images/tableviewcell.png)

![TableView](https://github.com/jrasmusson/ios-starter-kit/blob/master/basics/UITableView/images/blank-tableviewcell.png)

Select the cell and give it an identifier (e.g. ‘myCell’)

![TableView](https://github.com/jrasmusson/ios-starter-kit/blob/master/basics/UITableView/images/set-identifier.png)

Create an outlet for the TableView in your VC by control dragging

```swift
@IBOutlet var myTableView: UITableView!
```

Create some fake data

```swift
let cities = ["New York", "London", "San Francisco"]
```

Create an extension to implement the UITableView delegates and connect the data

```swift
extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cities.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath)
        cell.textLabel?.text = cities[indexPath.row]
        return cell
    }
    
}
```

Make yourself the delegate for the table

```swift
        myTableView.delegate = self
        myTableView.dataSource = self
```

Voila!

![TableView](https://github.com/jrasmusson/ios-starter-kit/blob/master/basics/UITableView/images/voila.png)

### Links that help
* [Apple UITableView docs](https://developer.apple.com/documentation/uikit/uitableview)
* [Human Interface Guidelines](https://developer.apple.com/design/human-interface-guidelines/ios/views/tables)