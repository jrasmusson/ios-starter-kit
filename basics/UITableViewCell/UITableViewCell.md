# UITableViewCell

## Programmatically

![New class](https://github.com/jrasmusson/ios-starter-kit/blob/master/basics/UITableViewCell/images/simple.png)

**ChannelCell.swift**

```swift
import UIKit

class ChannelCell: UITableViewCell {

    var channel: Channel? {
        didSet {
            guard let channel = channel else { return }
            nameLabel.text = channel.name
        }
    }

    let nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.font = UIFont.preferredFont(forTextStyle: .body)
        label.text = "Name"

        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        layout()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func layout() {
        addSubview(nameLabel)

        nameLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        nameLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
    }

}
```

**ViewController.swift**

```swift
struct Channel {
    let imageName: String
    let name: String
    let price: String
}

let channel1 = Channel(imageName: "crave", name: "Crave", price: "8")

var channels = [channel1]

class ViewController: UIViewController {

    let cellId = "cellId"

    func setup() {
        tableView.register(ChannelCell.self, forCellReuseIdentifier: cellId)
    }

// MARK:  - UITableView DataSource

extension ViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! ChannelCell

        let channel = channels[indexPath.row]
        cell.channel = channel
        cell.accessoryType = UITableViewCell.AccessoryType.none

        return cell
    }
}
```


## Xibs

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

![New class](https://github.com/jrasmusson/ios-starter-kit/blob/master/basics/UITableViewCell/images/newclass.png)

* Give it an identifier

![Identifier](https://github.com/jrasmusson/ios-starter-kit/blob/master/basics/UITableViewCell/images/identifier.png)


* Design your cell

![Design Cell](https://github.com/jrasmusson/ios-starter-kit/blob/master/basics/UITableViewCell/images/design.png)

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

![Voila](https://github.com/jrasmusson/ios-starter-kit/blob/master/basics/UITableViewCell/images/voila.png)

### Links that help
* [Apple UITableView docs](https://developer.apple.com/documentation/uikit/uitableviewcell)
* [Human Interface Guidelines](https://developer.apple.com/design/human-interface-guidelines/ios/views/tables)
