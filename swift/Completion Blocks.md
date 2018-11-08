# Completion Blocks

## How to define completion block for networking

Instead of 

```swift
    	func fetchHomeFeed() -> [User] {
    		let users = usersJsonArray.map { User(json: $0) }
          return users
    	}
```

Do

```swift
    	func fetchHomeFeed(completion: ([User]) -> () ) {
    	    let users = usersJsonArray.map { User(json: $0) }
           completion(users)
    	}
```

What we are saying here is instead of calling a method and returning some data. We are going to define a method as a closure, and have you return data by calling that.

The key to understanding closures is this line here

```completion: ([User]) -> ())```

This defines the input parameters to our closure (`[User]`(

So the way to read a method signature like this is

```swift
func fetchHomeFeed(completion: @escaping ([User]?, [Tweet]?, Error?) -> () ) {
```

I am calling a method called `fetchHomeFeed` that is going to probably do some network call, and when it gets the results it is going to execute *my* completion block with the variables `[User], [Tweet], [Error]` which itself happens to return nothing. But this is the way `fetchHomeFeed` is going to *callback* to my and pass me the data I need so that I can populate my views.

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

## Block debugging technique

If you suspect you have some buggy code, but you want to see if the callback works as expected, you can pull out the code in a completion block into a variable, and then by pass the buggy code completely.

```swift
        // buggy code
        _ = session.payBill(for: account, completion: { (possibleCode, possibleError) in

        })
```

First create a variable for the block you want to run by double click on the '{' in the completion block defintion and pull the contents of the block into a variable like this:

```swift
        let completion: (String?, Error?) -> Void = { (possibleCode, possibleError) in
             // buggy code
        }
```

(Note you will have to figure out the return types of the elements in the block...)

And then pass that variable into where the block used to be.

```swift
    _ = session.payBill(using: strategy, amount: paymentAmount, for: account, completion: completion)
```

Now if you want to by pass that call above. Simply create the test scenario/error you want, comment out the call to the buggy code, and invoke the callback directly like this.

```swift
        let error: Error = NSError(domain: "foo", code: 99, userInfo:nil)

        completion("Boom", error)
        return
```

Now you can test that the callback code works without having to go through the expensive network calls before.

## Example of how to convert method to closure

<img src="https://github.com/jrasmusson/ios-starter-kit/blob/master/swift/images/closures1.png" alt="drawing" width="800"/>


