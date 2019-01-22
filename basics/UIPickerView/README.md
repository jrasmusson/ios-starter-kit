# UIPickerView

## Simple

<img src="https://github.com/jrasmusson/ios-starter-kit/blob/master/basics/UIPickerView/images/simple-picker.png" alt="drawing" width="400"/>

```swift
import UIKit

class ViewController: UIViewController, UIPickerViewDataSource {

    var picker: UIPickerView!

    var pickerData: [String] = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()
    }

    func setupViews() {
        view.backgroundColor = .white

        pickerData = ["Item 1", "Item 2", "Item 3", "Item 4", "Item 5", "Item 6"]

        picker = UIPickerView()
        picker.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(picker)

        self.picker.delegate = self
        self.picker.dataSource = self

        picker.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        picker.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
}

extension ViewController: UIPickerViewDelegate {

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData[row]
    }

}
```



### Links that helpe

[Apple Docs](https://developer.apple.com/design/human-interface-guidelines/ios/controls/pickers/)
