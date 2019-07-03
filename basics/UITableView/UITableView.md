# UITableView

## How to custom format viewForHeaderInSection

<img src="https://github.com/jrasmusson/ios-starter-kit/blob/master/basics/UITableView/images/how-to-nudge-right.png" width="400"/>

## Simple

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

## Auto Layout

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

## Basic Setup

<img src="https://github.com/jrasmusson/ios-starter-kit/blob/master/basics/UITableView/images/basic-setup.png" width="400"/>

```swift
//
//  ViewController.swift
//  SecondaryTableView
//
//  Created by Jonathan Rasmusson (Contractor) on 2019-03-07.
//  Copyright © 2019 Jonathan Rasmusson. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let actionButtons = ["Change Name", "Change ID", "Change Password", "Change Recovery Email Address"]

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }

    func setupViews() {
        view.backgroundColor = .red

        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "myCell")

        tableView.delegate = self
        tableView.dataSource = self

        view.addSubview(tableView)

        tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 0).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: 0).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0).isActive = true

        tableView.reloadData()
    }

}

extension ViewController: UITableViewDelegate {

}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return actionButtons.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath)

        cell.textLabel?.text = actionButtons[indexPath.row]
        cell.accessoryType = UITableViewCell.AccessoryType.disclosureIndicator

        return cell
    }

}
```

## Headers

So `UITableViews` have headers and footers, but confusingly headers and footers can also be set via sections. Stick with headers and footers in sections (as these seem to be more common). But know that the API exists for you to create a custom `UIView` or `UITableViewCell` and set the header or footer like this.

```swift
tableView.tableHeaderView = ...
tableView.tableFooterView = ...
```

When I played with this the header and footer would be obscured if you have sections. So pick one or the other. But not both.

## Headers in Sections

Here is how you can set the headers within a `UITableView` section.

### Plain text

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

### Custom View

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

## Other things you can change

* [Focus style](https://developer.apple.com/documentation/uikit/uitableviewcell/focusstyle)
* [Editting style](https://developer.apple.com/documentation/uikit/uitableviewcell/1623234-editingstyle)
* [Selection style](https://developer.apple.com/documentation/uikit/uitableviewcell/1623221-selectionstyle)

### Links that help
* [Apple UITableView docs](https://developer.apple.com/documentation/uikit/uitableview)
* [Human Interface Guidelines](https://developer.apple.com/design/human-interface-guidelines/ios/views/tables)
