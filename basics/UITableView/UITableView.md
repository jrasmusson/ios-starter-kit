# How to setup a UITableView

## The Short
```swift
import UIKit

class ModemSupportViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    var myTableView: UITableView  =   UITableView()
    var itemsToLoad: [String] = ["One", "Two", "Three"]

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        // Get main screen bounds
        let screenSize: CGRect = UIScreen.main.bounds

        let screenWidth = screenSize.width
        let screenHeight = screenSize.height

        myTableView.frame = CGRect(x: 0, y: 0, width: screenWidth, height: screenHeight)

        myTableView.dataSource = self
        myTableView.delegate = self

        myTableView.register(UITableViewCell.self, forCellReuseIdentifier: "myCell")

        view.addSubview(myTableView)

        myTableView.reloadData()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return itemsToLoad.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell:UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath as IndexPath)

        cell.textLabel?.text = itemsToLoad[indexPath.row]

        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        print("User selected table row \(indexPath.row) and item \(itemsToLoad[indexPath.row])")
    }

}
```

### Links that help
* [Apple UITableView docs](https://developer.apple.com/documentation/uikit/uitableview)
* [Human Interface Guidelines](https://developer.apple.com/design/human-interface-guidelines/ios/views/tables)
