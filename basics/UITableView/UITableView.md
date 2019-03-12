# UITableView

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

### Plain text

```swift
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Header title"
    }
```

<img src="https://github.com/jrasmusson/ios-starter-kit/blob/master/basics/UITableView/images/header-title.png" width="400"/>

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

### Sections

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

## Accessory types

There are five different accessory types for a `UITableViewCell`.

```swift
    public enum AccessoryType : Int {
    
        case none // don't show any accessory view

        case disclosureIndicator // regular chevron. doesn't track

        case detailDisclosureButton // info button w/ chevron. tracks

        case checkmark // checkmark. doesn't track

        case detailButton // info button. tracks
    }
```

<img src="https://github.com/jrasmusson/ios-starter-kit/blob/master/basics/UITableView/images/accessories.png" width="400"/>



### Links that help
* [Apple UITableView docs](https://developer.apple.com/documentation/uikit/uitableview)
* [Human Interface Guidelines](https://developer.apple.com/design/human-interface-guidelines/ios/views/tables)
