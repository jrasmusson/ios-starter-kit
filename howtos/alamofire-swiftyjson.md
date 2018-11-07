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
//
//  ViewController.swift
//  ShawISED
//
//  Created by Jonathan Rasmusson on 2018-11-07.
//  Copyright © 2018 Jonathan Rasmusson. All rights reserved.
//

import Alamofire
import SwiftyJSON

struct User {

    let name: String
    let username: String
    let bioText: String
    let profileImageUrl: String

    init(json: JSON) {
        self.name = json["name"].stringValue
        self.username = json["username"].stringValue
        self.bioText = json["bio"].stringValue
        self.profileImageUrl = json["profileImageUrl"].stringValue
    }
}

struct Tweet {
    let user: User
    let message: String

    init(json: JSON) {
        let userJson = json["user"]

        self.user = User(json: userJson)
        self.message = json["message"].stringValue
    }
}

class ViewController: UIViewController {

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
}

```
