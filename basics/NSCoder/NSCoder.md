# NSCoder

A way of encoding custom objects to be stored on disk. Same tech used for JSON encoding. To be `Encodable` means you only contain standard object types (strings, floats, ints etc).

## Example

```swift
import UIKit

struct Item: Encodable {
    let name: String
}

class ViewController: UIViewController {

    var items = [Item(name: "Kevin"), Item(name: "Sam")]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Create your own plist file entry to store your encodable objects
        let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")
        print(dataFilePath)
        
        // Encode them as a plist
        let encoder = PropertyListEncoder()
        let data = try? encoder.encode(items)
        try? data?.write(to: dataFilePath!)
    }
}
```

![](on-disk.png)


### Links that help
* [Apple Docs](https://developer.apple.com/documentation/foundation/nscoder)
