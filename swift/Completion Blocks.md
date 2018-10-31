# Completion Blocks

## How to define completion block for networking

Instead of 

```swift
    	func fetchHomeFeed() -> [User] {
```

Do

```swift
    	func fetchHomeFeed(completion: () -> () ) {
```

Then call like

```swift
        Service.sharedInstance.fetchHomeFeed(completion: {

        })
        
        // or
        
        Service.sharedInstance.fetchHomeFeed {

        }

```

Now simply add the parameters you want to pass back in the block like this

```swift
        func fetchHomeFeed(completion: @escaping ([User]) -> () ) {

            let users = usersJsonArray.map { User(json: $0) }
            completion(users)
        }
```

And call it like this

```swift
        Service.sharedInstance.fetchHomeFeed { (jsonUsers) in
            self.users = jsonUsers
        }
```

See the BuildThatApp Twitter example. Here the example in full.

Service.swift
```swift
import Foundation
import Alamofire
import SwiftyJSON

struct Service {

    static let sharedInstance = Service()

    // important! Error must be Optional here - only way you can pass back a nil
    func fetchHomeFeed(completion: @escaping ([User]?, [Tweet]?, Error?) -> () ) {

        Alamofire.request("https://api.letsbuildthatapp.com/twitter/home").responseJSON { response in
//        Alamofire.request("https://api.letsbuildthatapp.com/twitter/home_with_error").responseJSON { response in

            if let error = response.error {
                completion (nil, nil, error)
                return
            }

            guard let data = response.result.value else { return }

            let json = JSON(data)

            guard let usersJsonArray = json["users"].array, let tweetsJsonArray = json["tweets"].array else {
                let error = NSError(domain: "com.rsc.org", code: 1, userInfo: [NSLocalizedDescriptionKey: "Parsing not valid in JSON"])
                completion(nil, nil, error)
                return
            }

            let users = usersJsonArray.map { User(json: $0) }
            let tweets = tweetsJsonArray.map { Tweet(json: $0) }

            completion(users, tweets, nil)
        }
    }
}
```

ViewController.swift
```swift
    func fetchHomeFeed() {
        Service.sharedInstance.fetchHomeFeed { (users, tweets, error) in
            guard error == nil, let users = users, let tweets = tweets else {

                // TODO - change these into typed exceptions
                if let error = error as NSError? {

                    if error.domain == NSURLErrorDomain {
                        self.errorMessageLabel.text = "No network"
                    }

                    if error.code == 1 {
                        self.errorMessageLabel.text = "Parsing error"
                    }
                }

                self.errorMessageLabel.isHidden = false

                return
            }

            self.errorMessageLabel.isHidden = true

            self.users = users
            self.tweets = tweets
            self.collectionView?.reloadData()
        }
    }
```
