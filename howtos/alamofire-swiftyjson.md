# How to Alamofire JSON Parsing

CocoaPods:

```swift

  > pod init
  
  # Pods for Twitter
  pod 'Alamofire'
  
  > pod update
```

Service.swift

```swift
import Foundation
import Alamofire

enum ServiceError: Error {
    case noData
    case parsingJSON
}

struct Tweet: Codable {
    let message: String
    let user: User
}

struct Tweets: Codable {
    let tweets: [Tweet]
}

struct User: Codable {
    let name: String
    let bio: String
}

struct Service {

    static let sharedInstance = Service()

    func fetchTweets(completion: @escaping (Tweets?, Error?) -> () ) {

        Alamofire.request("https://api.letsbuildthatapp.com/twitter/home").responseData { response in

            switch response.result {
            case .success:

                guard let jsonData = response.result.value else {
                    completion(nil, ServiceError.noData)
                    return
                }

                self.parseTweets(jsonData: jsonData, completion: completion)

            case .failure(let error):
                completion(nil, error)
            }
        }
    }

    private func parseTweets(jsonData: Data, completion: (Tweets?, Error?) -> ()) {
        let decoder = JSONDecoder()
        do {
            let tweets = try decoder.decode(Tweets.self, from: jsonData)
            completion(tweets, nil)
        } catch {
            completion(nil, ServiceError.parsingJSON)
        }
    }

}
```

ViewController.swift

```swift
import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        fetchTweets()
    }

    // MARK: Network
    func fetchTweets() {
        Service.sharedInstance.fetchTweets { (tweets, error) in
            print("Tweets: \(String(describing: tweets))")
        }
    }

}
```
