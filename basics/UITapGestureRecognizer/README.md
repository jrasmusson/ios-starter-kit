# UITapGestureRecognizer

```swift
import UIKit

class ViewController: UIViewController {

    @IBOutlet var myUIImageView: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()

        let singleTap = UITapGestureRecognizer(target: self, action: #selector(myUIImageViewTapped(_: )))
        self.myUIImageView.addGestureRecognizer(singleTap)
    }

    @objc func myUIImageViewTapped(_ recognizer: UITapGestureRecognizer) {
        if recognizer.state == UIGestureRecognizer.State.ended {
            print("myUIImageView has been tapped by the user.")
        }
    }
}
```
