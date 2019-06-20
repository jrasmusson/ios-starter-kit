# Xibs or Nibs

## How to load a Xib

Design your Xib (`PaymentTile.xib`) in Interface Builder. 

Design your outlets supporting the xib (`PaymentTile.swift`).

```swift
import Foundation
import UIKit

class PaymentTile: UIView {

    @IBOutlet weak var headerImageView: UIImageView!
    @IBOutlet weak var headerLabel: UILabel!
    @IBOutlet weak var headerDescription: UILabel!
    @IBOutlet weak var button: UIButton!
    @IBOutlet weak var bottomDiv: UIView!

    override func awakeFromNib() {
        super.awakeFromNib()

        headerDescription.setLineSpacing(lineSpacing: 1.43)
    }
}
```

 Then load into your custom view like this.

```swift
class MyView: UIView {

    let headerLabel: UILabel = UILabel()

    lazy var myShawTile: PaymentTile! = { MyView.makeTile() }()

    override init(frame: CGRect) {
        super.init(frame: frame)

        commonInit()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func commonInit() {
        translatesAutoresizingMaskIntoConstraints = false
        initViews()
        initLayout()
    }

    func initViews() {
		...
		// fire up via responder chain (nil for target)
		myShawTile.button.addTarget(nil, action: #selector(PaymentMethodTilePickerResponder.didTapMakeAPayment), for: .primaryActionTriggered)
    }

    func initLayout() {

    }

    static func makeTile() -> PaymentTile? {

		  // Class and Xib
        guard let tile = Bundle(for: PaymentTile.self).loadNibNamed("PaymenTile", owner: nil, options: nil)?.first as? PaymentTile else {
            return nil
        }

        tile.translatesAutoresizingMaskIntoConstraints = false

        return tile
    }
}


@objc
protocol PaymentMethodTilePickerResponder: AnyObject {
    func didTapMakeAPayment()
    func didTapLearnMore()
    func didTapFindAStore()
}    
```

Catch via responder chain here.

```swift
extension MainViewController: PaymentMethodTilePickerResponder {
    func didTapMakeAPayment() {
    	// do something
    }
```

