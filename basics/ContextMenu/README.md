# Context Menus

```swift
import UIKit

func makeLabel() -> UILabel {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.text = "Title"
    label.textAlignment = .center
    label.textColor = .black
    label.font = UIFont.systemFont(ofSize: 18)
    label.numberOfLines = 0

    return label
}

func makeButton() -> UIButton {
    let button = UIButton()
    button.translatesAutoresizingMaskIntoConstraints = false
    button.backgroundColor = .lightGray
    button.setTitleColor(.black, for: .normal)
    button.layer.cornerRadius = 10
    button.contentEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)

    return button
}

func checkForErrors(error: Error?) {
    guard error == nil else {
        preconditionFailure(String(describing: error))
    }
}
```