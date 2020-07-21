# Networking

```swift
import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        startLoad()
    }

    func startLoad() {
        let url = URL(string: "https://uwyg0quc7d.execute-api.us-west-2.amazonaws.com/prod/account")!
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Error: \(error)")
                return
            }
            guard let httpResponse = response as? HTTPURLResponse,
                (200...299).contains(httpResponse.statusCode) else {
                print("Server Error")
                return
            }
            if let mimeType = httpResponse.mimeType, mimeType == "application/json",
                let data = data,
                let string = String(data: data, encoding: .utf8) {
                DispatchQueue.main.async {
                    // update UI
                    print(string)
                }
            }
        }
        task.resume()
    }
}
```


### Links that help

- [Apple Networking](https://developer.apple.com/documentation/foundation/url_loading_system)
- [Apple Website into Memory](https://developer.apple.com/documentation/foundation/url_loading_system/fetching_website_data_into_memory)
- [Learn App Making](https://learnappmaking.com/urlsession-swift-networking-how-to/)



