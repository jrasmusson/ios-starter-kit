# Map, Filter, Reduce

## Filter

```swift
let digits = [1,4,10,15]
let even = digits.filter { $0 % 2 == 0 }
// [4, 10]
```

## Map

Use map to loop over a collection and apply the same operation to every element. i.e. hidding all elements.

```swift
let allViewElements = [
    activateModemButton,
    chatButton,
    readyToActivateViewContainer,
    failedActivationViewContainer,
    readyToActivateViewSpacer,
    currentInternetStackView,
    manageInternetButton,
    descriptionLabel
]
_ = allViewElements.map { $0.isHidden = true }
```

### How to map instead of for loop

Instead of 

```swift
var users = [User]()

for userJson in usersJsonArray! {
  let user = User(json: userJson)
  users.append(user)
}
```
Go
```swift
let users = usersJsonArray!.map { User(json: $0) }
```

Map takes each element in the collection, and lets you do something to it in the brackets. Think of it as taking the for loop, scrunching the brackets onto one line, and letting you do your magic there.

Here is a slightly more complicated example. The trick is to create `init` methods as constructors.

```swift
let tweetsJsonArray = json["tweets"].array
var tweets = [Tweet]()

for tweetJson in tweetsJsonArray! {
  let userJson = tweetJson["user"]

  let user = User(json: userJson)
  let message = tweetJson["message"].stringValue
  let tweet = Tweet(user: user, message: message)

  tweets.append(tweet)
}
```

## foreach

```swift
[headline, body, footnote].forEach {
$0?.adjustsFontForContentSizeCategory = true }
```

Create a constructor taking only json

```swift
import SwiftyJSON

struct Tweet {
    let user: User
    let message: String

    init(json: JSON) {
        let userJson = json["user"]

        self.user = User(json: userJson)
        self.message = json["message"].stringValue
    }
}
```

Refactor your for loop down to this

```swift
var tweets = [Tweet]()

for tweetJson in tweetsJsonArray! {
  let tweet = Tweet(json: tweetJson)
  tweets.append(tweet)
}
```

Then apply the same map again

```swift
let tweets = tweetsJsonArray!.map { Tweet(json: $0) }
```

Final refactoring looks beautiful :)

```swift
    func fetchHomeFeed(completion: @escaping ([User], [Tweet]) -> () ) {

        Alamofire.request("https://api.letsbuildthatapp.com/twitter/home").responseJSON { response in

            guard let data = response.result.value else { return }

            let json = JSON(data)
            
            let usersJsonArray = json["users"].array
            let users = usersJsonArray!.map { User(json: $0) }

            let tweetsJsonArray = json["tweets"].array
            let tweets = tweetsJsonArray!.map { Tweet(json: $0) }

            completion(users, tweets)
        }
    }
 ```
 
 ## Reduce
 
 Use `reduce` to combine all items in a collection to create a single new value. The reduce method takes two values, an initial value and a combine closure. 
 
 ```swift
 let items = [2.0,4.0,5.0,7.0]
let total = items.reduce(10.0, +)
// 28.0

let codes = ["abc","def","ghi"]
let text = codes.reduce("", +)
// "abcdefghi"

let names = ["alan","brian","charlie"]
let csv = names.reduce("===") {text, name in "\(text),\(name)"}
// "===,alan,brian,charlie"

## FlatMap and CompactMap

See loaf website for example.

```

## Examples

```swift
// Returns our categories from our fetched subscription offers, sorted, and no duplicates
var categories: [String] {
    let offers = fetchedSubscriptionOffers else {
        return []
    }

    return Set(offers.map { $0.upsellChannelType }).map { $0 }.compactMap { $0 }.sorted(by: <)
}
```



### Links that help
[Use your loaf - Map Filter Reduce](https://useyourloaf.com/blog/swift-guide-to-map-filter-reduce)
