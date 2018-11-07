# How Alamofire SwiftyJson

CocoaPods:

```swift

  > pod init
  
  # Pods for Twitter
  pod 'Alamofire'
  pod 'SwiftyJSON'
  
  > pod update
```

Code

```swift
import Alamofire
import SwiftyJSON

class HomeController: UICollectionViewController {

	let tweets: [Tweet] = {
		return []
	}()

    override func viewDidLoad() {
        super.viewDidLoad()
        Alamofire.request("https://api.letsbuildthatapp.com/twitter/home").responseJSON { response in
            print("Request: \(String(describing: response.request))")   // original url request
            print("Response: \(String(describing: response.response))") // http url response
            print("Result: \(response.result)")                         // response serialization result

            if let json = response.result.value {
                print("JSON: \(json)") // serialized json response

                let swiftyJsonVar = JSON(response.result.value!)

                if let tweetsLocal = swiftyJsonVar["tweets"].arrayObject {
                    print("tweets: \(tweetsLocal)")
                }
            }
        }
    }
```
