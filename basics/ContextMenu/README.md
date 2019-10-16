# Context Menus

## Simple

![TableView](https://github.com/jrasmusson/ios-starter-kit/blob/master/basics/ContextMenu/images/simple.gif)

```swift
//
//  ContextViewController.swift
//  Foo2
//
//  Created by Jonathan Rasmusson (Contractor) on 2019-10-16.
//  Copyright © 2019 Jonathan Rasmusson. All rights reserved.
//

import UIKit

class ContextViewController: UIViewController {

    let menuView = UIView()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }

    func setupViews() {
        view.backgroundColor = .systemBackground

        menuView.backgroundColor = .systemBlue
        menuView.frame.size = .init(width: 100, height: 100)
        view.addSubview(menuView)

        let interaction = UIContextMenuInteraction(delegate: self)
        menuView.addInteraction(interaction)
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        menuView.center = view.center
    }
}


extension ContextViewController: UIContextMenuInteractionDelegate {

    func contextMenuInteraction(_ interaction: UIContextMenuInteraction, configurationForMenuAtLocation location: CGPoint) -> UIContextMenuConfiguration? {
        return UIContextMenuConfiguration(identifier: nil, previewProvider: nil) { suggestedActions in

            // Create an action for sharing
            let share = UIAction(title: "Share", image: UIImage(systemName: "square.and.arrow.up")) { action in
                // Show system share sheet
                self.present(ShareViewController(), animated: true)
            }

            // Create an action for renaming
            let rename = UIAction(title: "Rename", image: UIImage(systemName: "square.and.pencil")) { action in
                // Perform renaming
            }

            // Here we specify the "destructive" attribute to show that it’s destructive in nature
            let delete = UIAction(title: "Delete", image: UIImage(systemName: "trash"), attributes: .destructive) { action in
                // Perform delete
            }

            // Create and return a UIMenu with all of the actions as children
            return UIMenu(title: "", children: [share, rename, delete])
        }
    }

}

class ShareViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }

    func setupViews() {
        view.backgroundColor = .systemRed

        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Swipe down to dismiss"

        view.addSubview(label)

        label.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        label.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
}
```

## TableViewController

No need to explicitly register interaction. Simple create and return the menu for each cell.

![TableView](https://github.com/jrasmusson/ios-starter-kit/blob/master/basics/ContextMenu/images/table.gif)

```swift
import UIKit

class TableViewController: UITableViewController {

    // MARK: ContextMenuDemo

    static var title: String { return "Table View" }

    // MARK: TableViewController

    private let identifier = "identifier"

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = Self.title
        tableView.allowsSelection = false
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: identifier)
    }

    // MARK: - UITableViewDelegate

    /*
     In a table view, there's no need to register an interaction -
     this delegate method is where you create and return a menu.
     */

    override func tableView(_ tableView: UITableView, contextMenuConfigurationForRowAt indexPath: IndexPath, point: CGPoint) -> UIContextMenuConfiguration? {
        return UIContextMenuConfiguration(identifier: nil, previewProvider: nil) { suggestedActions in

            // Create an action for sharing
            let share = UIAction(title: "Share", image: UIImage(systemName: "square.and.arrow.up")) { action in
                // Show system share sheet
                self.present(ShareViewController(), animated: true)
            }

            // Create an action for renaming
            let rename = UIAction(title: "Rename", image: UIImage(systemName: "square.and.pencil")) { action in
                // Perform renaming
            }

            // Here we specify the "destructive" attribute to show that it’s destructive in nature
            let delete = UIAction(title: "Delete", image: UIImage(systemName: "trash"), attributes: .destructive) { action in
                // Perform delete
            }

            // Create and return a UIMenu with all of the actions as children
            return UIMenu(title: "", children: [share, rename, delete])
        }
    }

    // MARK: - UITableViewDataSource

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Fixtures.lorem.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath)
        cell.textLabel?.text = Fixtures.lorem[indexPath.row]
        return cell
    }
}
```

## Preview

![TableView](https://github.com/jrasmusson/ios-starter-kit/blob/master/basics/ContextMenu/images/preview.gif)

```swift
import UIKit

/*

 This view controller displays a square that can open a menu, and uses a view controller for the menu preview.
 When the preview is tapped, it pushes that view controller.

 */

/// A view controller used for previewing and when an item is selected
private class MountainsPreviewViewController: UIViewController {
    private let imageView = UIImageView()

    override func viewDidLoad() {
        super.viewDidLoad()

        let mountains = UIImage(named: "tron")!

        imageView.image = mountains
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(imageView)

        NSLayoutConstraint.activate([
            imageView.leftAnchor.constraint(equalTo: view.leftAnchor),
            imageView.rightAnchor.constraint(equalTo: view.rightAnchor),
            imageView.topAnchor.constraint(equalTo: view.topAnchor),
            imageView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])

        // The preview will size to the preferredContentSize, which can be useful
        // for displaying a preview with the dimension of an image, for example.
        // Unlike peek and pop, it doesn't automatically scale down for you.

        let width = view.bounds.width
        let height = mountains.size.height * (width / mountains.size.width)
        preferredContentSize = CGSize(width: width, height: height)
    }
}

class VCPreviewSingleViewController: UIViewController, ContextMenuDemo {

    // MARK: ContextMenuDemo

    static var title: String { return "UIViewController (Single View)" }

    // MARK: CustomPreviewController

    private let photoView = UIImageView()

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = self.title
        view.backgroundColor = .systemBackground

        photoView.image = UIImage(named: "tron")
        photoView.contentMode = .scaleAspectFill
        photoView.clipsToBounds = true
        photoView.isUserInteractionEnabled = true // important!
        photoView.frame.size = .init(width: 100, height: 100)
        view.addSubview(photoView)

        /*

         Here we create an interaction, give it a delegate, and
         add it to a view. This tells UIKit to call the delegate
         methods when the view is long-press or 3D touched, and
         display a menu if the delegate returns one.

         */

        let interaction = UIContextMenuInteraction(delegate: self)
        photoView.addInteraction(interaction)
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        photoView.center = view.center
    }
}

extension VCPreviewSingleViewController: UIContextMenuInteractionDelegate {

    /*

     The `previewProvider` argument needs a function
     that returns a view controller. You can do this with a
     closure, or pass in a method that creates the view controller
     (in this case, the preview view controller initializer).

     We can also implement `willPerformPreviewActionForMenuWith`
     to respond to the user tapping on the preview.

     */

    func contextMenuInteraction(_ interaction: UIContextMenuInteraction, configurationForMenuAtLocation location: CGPoint) -> UIContextMenuConfiguration? {
        return UIContextMenuConfiguration(identifier: nil, previewProvider: MountainsPreviewViewController.init) { suggestedActions in
            return self.makeDefaultDemoMenu()
        }
    }

    func contextMenuInteraction(_ interaction: UIContextMenuInteraction, willPerformPreviewActionForMenuWith configuration: UIContextMenuConfiguration, animator: UIContextMenuInteractionCommitAnimating) {

        // If we used a view controller for our preview, we can pull it out of the animator and show it once the commit animation is complete.
        animator.addCompletion {
            if let viewController = animator.previewViewController {
                self.show(viewController, sender: self)
            }
        }
    }
}


import UIKit

protocol ContextMenuDemo {
    static var title: String { get }
}

extension ContextMenuDemo {
    func makeDefaultDemoMenu() -> UIMenu {

        // Create a UIAction for sharing
        let share = UIAction(title: "Share", image: UIImage(systemName: "square.and.arrow.up")) { action in
            // Show system share sheet
        }

        // Create an action for renaming
        let rename = UIAction(title: "Rename", image: UIImage(systemName: "square.and.pencil")) { action in
            // Perform renaming
        }

        // Here we specify the "destructive" attribute to show that it’s destructive in nature
        let delete = UIAction(title: "Delete", image: UIImage(systemName: "trash"), attributes: .destructive) { action in
            // Perform delete
        }

        // Create and return a UIMenu with all of the actions as children
        return UIMenu(title: "", children: [share, rename, delete])
    }
}
```

### Links that help

- [Apple HIG ContextMenus](https://developer.apple.com/design/human-interface-guidelines/ios/controls/context-menus/)
- [Apple ContextMenus](https://developer.apple.com/documentation/swiftui/contextmenu)
- [Example 1](https://kylebashour.com/posts/context-menu-guide)
