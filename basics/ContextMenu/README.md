# Context Menus

<img src="https://github.com/jrasmusson/ios-starter-kit/blob/master/basics/ContextMenu/images/simple.png" alt="drawing" width="400"/>

```swift
import UIKit

class ContextViewController: UIViewController {

    let menuView = UIView()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }

    func setupViews() {
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
```

### Links that help

- [Apple HIG ContextMenus](https://developer.apple.com/design/human-interface-guidelines/ios/controls/context-menus/)
- [Apple ContextMenus](https://developer.apple.com/documentation/swiftui/contextmenu)
- [Example 1](https://kylebashour.com/posts/context-menu-guide)
