# Swipe Gesture

## Simple

Moving your finger -> from left-to-right is a `.right` swipe direction.
Moving your finger <- from right-to-left is a `.left` swipe direction

So the direction of the arrow is the direction of the swipe:
 - <- swipe left
 - -> swipe right
 
```swift
import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()
    }

    func setupViews() {

        view.backgroundColor = .red

        let leftSwipe = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipes(_:)))
        let rightSwipe = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipes(_:)))

        leftSwipe.direction = .left
        rightSwipe.direction = .right

        view.addGestureRecognizer(leftSwipe)
        view.addGestureRecognizer(rightSwipe)
    }

    @objc func handleSwipes(_ sender:UISwipeGestureRecognizer) {

        if (sender.direction == .left) {
            print("Swipe Left")
        }

        if (sender.direction == .right) {
            print("Swipe Right")
        }
    }
}
```

