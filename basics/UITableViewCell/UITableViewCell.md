# UITableViewCell

## Programmatically

**CustomCell.swift**

```swift
import UIKit

class CustomCell: UITableViewCell {

    let titleLabel = UILabel()
    
    var game: String? {
        didSet {
            guard let game = game else { return }
            titleLabel.text = game
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
        layout()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension CustomCell {

    func setup() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func layout() {
        // don't disable translatesAutoresizingMaskIntoConstraints on the cell itself
        contentView.addSubview(titleLabel) // important!

        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalToSystemSpacingAfter: leadingAnchor, multiplier: 1),
            titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
        ])
    }
}
```

**ViewController.swift**

```swift
import UIKit

class ViewController: UIViewController {

let games = [
                "Pacman",
                "Space Invaders",
                "Space Patrol",
    ]
    
    let cellId = "cellId"

    var tableView = UITableView()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }

    func setupViews() {
        tableView.delegate = self
        tableView.dataSource = self

        tableView.register(CustomCell.self, forCellReuseIdentifier: cellId)
        tableView.tableFooterView = UIView()

        view = tableView
    }
}

extension ViewController: UITableViewDelegate {

}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! CustomCell

        cell.game = games[indexPath.row]
        cell.accessoryType = UITableViewCell.AccessoryType.disclosureIndicator

        return cell
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return games.count
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

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
* [Customizing Cells](https://developer.apple.com/documentation/uikit/views_and_controls/table_views/configuring_the_cells_for_your_table)
* [Human Interface Guidelines](https://developer.apple.com/design/human-interface-guidelines/ios/views/tables)
