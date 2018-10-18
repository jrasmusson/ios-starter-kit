# Map, Filter, Reduce

## Map

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

