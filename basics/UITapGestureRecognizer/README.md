# UITapGestureRecognizer

```swift
import UIKit

class ViewController: UIViewController {

    @IBOutlet var myUIImageView: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()

        let singleTap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "myUIImageViewTapped:")
        self.myUIImageView.addGestureRecognizer(singleTap)
    }

    func myUIImageViewTapped(recognizer: UITapGestureRecognizer) {
        if(recognizer.state == UIGestureRecognizerState.Ended){
            println("myUIImageView has been tapped by the user.")
        }
    }

}
```