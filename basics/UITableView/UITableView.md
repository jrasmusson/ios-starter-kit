# UITableView

<img src="https://github.com/jrasmusson/ios-starter-kit/blob/master/basics/UITableView/images/basic.png" width="400"/>

```swift
import UIKit

class ViewController: UIViewController {

let games = [
                "Pacman",
                "Space Invaders",
                "Space Patrol",
                "Galaga",
                "Donkey Kong",
                "Frogger",
                "Defender",
                "Dig Dug",
                "Zaxxon",
                "Qbert",
                "Burger Time",
                "Joust",
                "Paperboy",
                "Missle Command",
                "Pole Position",
                "Robotron",
                "Spy Hunter",
                "Star Wars",
                "1942",
                "Dragon's Lair",
                "Moon Patrol",
                "Centipede",
                "Bezerk",
                "Elevator Action",
                "Gauntlet",
                "Sinistar",
                "Tempest",
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

        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellId)

        tableView.tableFooterView = UIView() // hide empty rows

        view = tableView
    }
}

extension ViewController: UITableViewDelegate {

}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)

        cell.textLabel?.text = games[indexPath.row]
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

# UITableViewController

```swift
import UIKit

class ViewController: UITableViewController {
    
    let games = ["Pacman",
                "Space Invaders",
                "Space Patrol",
                "Galaga",
                "Donkey Kong"]
    
    let cellId = "cellId"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    func setupViews() {
        navigationItem.title = "Games"
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellId)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
        
        cell.textLabel?.text = games[indexPath.row]
        cell.accessoryType = UITableViewCell.AccessoryType.disclosureIndicator
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return games.count
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}
```



## How to custom format viewForHeaderInSection

<img src="https://github.com/jrasmusson/ios-starter-kit/blob/master/basics/UITableView/images/how-to-nudge-right.png" width="400"/>

### Simple

If all you need is to nudge a label 16pts to the right, extend UILabel and redraw the text

```swift
class IndentedLabel: UILabel {
    override func drawText(in rect: CGRect) {
        let customRect = rect.insetBy(dx: 16, dy: 0)
        super.drawText(in: customRect)
    }
}
```

And then use like this.

```swift
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {

        let label = IndentedLabel()

        if section == 0 {
            label.text = "Short names"
        } else {
            label.text = "Long names"
        }

        label.backgroundColor = .lightBlue
        label.textColor = .darkBlue
        label.font = UIFont.boldSystemFont(ofSize: 16)

        return label
    }
```

### Auto Layout

If you need something more complicated, consider creating a custom view. Both here do the same thing.

```swift
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {

        let containerView = UIView()
        containerView.backgroundColor = .lightBlue

        let label = UILabel()
        containerView.addSubview(label)

        label.translatesAutoresizingMaskIntoConstraints = false
        label.centerYAnchor.constraint(equalTo: containerView.centerYAnchor).isActive = true
        label.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16).isActive = true

        if section == 0 {
            label.text = "Short names"
        } else {
            label.text = "Long names"
        }

        label.textColor = .darkBlue
        label.font = UIFont.boldSystemFont(ofSize: 16)

        return containerView
    }
```

Note: `containerView` doesn't need `translatesAutoresizingMaskIntoConstraints = false` because the UITable sets or draws the rect for thge section header itself.

## Headers

So `UITableViews` have headers and footers, but confusingly headers and footers can also be set via sections. Stick with headers and footers in sections (as these seem to be more common). But know that the API exists for you to create a custom `UIView` or `UITableViewCell` and set the header or footer like this.

```swift
tableView.tableHeaderView = ...
tableView.tableFooterView = ...
```

When I played with this the header and footer would be obscured if you have sections. So pick one or the other. But not both.

### Hide extra rows in footer

```swift
tableView.tableFooterView = UIView() // hide empty rows
```

### Headers in Sections

Here is how you can set the headers within a `UITableView` section.

#### Plain text

Headers and sections are really one in the same. You can tell from the API `titleForHeaderInSection`. When you only have one it's a header. But as soon as you have multiple they act more like sections.

```swift
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "Section 1"
        }
        else {
            return "Section 2"
        }
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
```

<img src="https://github.com/jrasmusson/ios-starter-kit/blob/master/basics/UITableView/images/sections.png" width="400"/>

A similar API exists for footers.

#### Custom View

```swift

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Header title"
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let greenView = UIView()

        greenView.backgroundColor = .green
        greenView.translatesAutoresizingMaskIntoConstraints = false
        greenView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        greenView.widthAnchor.constraint(equalToConstant: 100).isActive = true

        return greenView
    }
}
```

## Navigation title

Sometimes you will see a nice title at the top of your table. Often that is a nav bar with a title set.

```swift
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()

        let navigatorController = UINavigationController(rootViewController: ViewController())
        window?.rootViewController = navigatorController

        return true
    }
```

```swift
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()

        navigationItem.title = "Actions"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
```

<img src="https://github.com/jrasmusson/ios-starter-kit/blob/master/basics/UITableView/images/navigation-bar.png" width="400"/>

## Custom Cell Styles

```swift
let cell = tableView.dequeueReusableCell(withIdentifier: "myCell") ?? UITableViewCell(style: .default, reuseIdentifier: "myCell")
```

<img src="https://github.com/jrasmusson/ios-starter-kit/blob/master/basics/UITableView/images/default-cell-styles.png" width="400"/>

## Cell Reuse

Do this is you need a cell created a specific way.

```swift
func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

    let offer = viewModel.offersForSelectedCategory[indexPath.row]

    let cell: ChannelAddOnsViewControllerCell

    if let existingCell = tableView.dequeueReusableCell(withIdentifier: ChannelAddOnsView.cellId) as? ChannelAddOnsViewControllerCell {
        cell = existingCell
    } else {
        cell = ChannelAddOnsViewControllerCell(style: .default, reuseIdentifier: ChannelAddOnsView.cellId)
    }

    cell.subscriptionOffer = offer

    return cell
}
```
## Accessory types

There are five different accessory types for a `UITableViewCell`.

```swift
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath)

        cell.textLabel?.text = actionButtons[indexPath.row]

        if indexPath.row == 0 {
            cell.accessoryType = UITableViewCell.AccessoryType.none
        } else if indexPath.row == 1 {
            cell.accessoryType = UITableViewCell.AccessoryType.disclosureIndicator
        } else if indexPath.row == 2 {
            cell.accessoryType = UITableViewCell.AccessoryType.detailDisclosureButton
        } else if indexPath.row == 3 {
            cell.accessoryType = UITableViewCell.AccessoryType.checkmark
        } else if indexPath.row == 4 {
            cell.accessoryType = UITableViewCell.AccessoryType.detailButton
        }

        return cell
    }
```
<img src="https://github.com/jrasmusson/ios-starter-kit/blob/master/basics/UITableView/images/accessories.png" width="400"/>

## TableView Style

```swift
let tableView = UITableView(frame: .zero, style: .plain)
let tableView = UITableView(frame: .zero, style: .grouped)
```

<img src="https://github.com/jrasmusson/ios-starter-kit/blob/master/basics/UITableView/images/grouped.png" width="400"/>

## Editing Styles

There are two ways you can edit the rows and provide actions on a _UITableViewCell_. You can either return an array of action buttons with closures like this.

```swift
override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
    if editingStyle == .delete {
        objects.remove(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .fade)
    } else if editingStyle == .insert {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
    }
}
```

- [How to swipe to delete tableViewCelles](https://www.hackingwithswift.com/example-code/uikit/how-to-swipe-to-delete-uitableviewcells)

Or you can create a custom action button (like on a navbarController) and do your work via target-action there.

```swift
    lazy var addButtonItem: UIBarButtonItem = {
        let barButtonItem = UIBarButtonItem(title: "Add", style: .plain, target: self, action: #selector(addGamePressed))
        return barButtonItem
    }()

    @objc
    func addGamePressed() {
        games.append("Ms Pacman")
        let indexPath = IndexPath(row: games.count - 1, section: 0)

        tableView.beginUpdates()
        tableView.insertRows(at: [indexPath], with: .fade)
        tableView.endUpdates()
    }
```

Either way will work. More just a matter of design and whatever makes sense for your app.

## Other things you can change

* [Focus style](https://developer.apple.com/documentation/uikit/uitableviewcell/focusstyle)
* [Editting style](https://developer.apple.com/documentation/uikit/uitableviewcell/1623234-editingstyle)
* [Selection style](https://developer.apple.com/documentation/uikit/uitableviewcell/1623221-selectionstyle)

### Links that help
* [Apple UITableView docs](https://developer.apple.com/documentation/uikit/uitableview)
* [Human Interface Guidelines](https://developer.apple.com/design/human-interface-guidelines/ios/views/tables)
