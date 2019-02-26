# Protocols & Unit Testing

Protocols offer a much nicer alternative to mocking when it comes to unit testing. Instead of working with mock objects (and having to set expectations and deal with all that complexity) you can create concrete objects, hard code the functionality you want, leading to a much simpler easier to read and understand test.

```swift
import UIKit

protocol Confirmable {
    var title: String { get set }
    func confirm()
}

struct ViewModel: Confirmable {
    var title: String

    init(title: String) {
        self.title = title
    }

    func confirm() {
        // ...
    }
}

class ViewController: UIViewController {

    var viewModel: Confirmable

    init(viewModel: Confirmable = ViewModel(title: "Default")) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    func didTapOnButton(sender: UIButton) {
        viewModel.title = sender.titleLabel?.text ?? "Empty"
        viewModel.confirm()
    }

}
```

```swift
import XCTest
@testable import ProtocolUnitTests2

class FakeViewModel : Confirmable {
    var title: String = ""

    var didConfirm = false
    func confirm() {
        didConfirm = true
    }
}

class ProtocolUnitTests2Tests: XCTestCase {

    var vc : ViewController!
    var viewModel : FakeViewModel!

    override func setUp() {
        viewModel = FakeViewModel()
        vc = ViewController(viewModel: viewModel)
        vc.loadViewIfNeeded()
    }

    func testAddButtonTap() {
        let addButton = makeButton(title: "Add")
        vc.didTapOnButton(sender: addButton)

        XCTAssertEqual("Add", viewModel.title)
        XCTAssertTrue(viewModel.didConfirm)
    }

    func makeButton(title: String) -> UIButton {
        let button = UIButton()
        button.setTitle(title, for: .normal)

        return button
    }
}
```

### Links that help

* [Example](https://riptutorial.com/swift/example/8271/leveraging-protocol-oriented-programming-for-unit-testing)