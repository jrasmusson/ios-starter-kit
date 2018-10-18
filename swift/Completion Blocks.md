# Completion Blocks

How to create completion block

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
```

or

```swift
        Service.sharedInstance.fetchHomeFeed {

        }
```

Now simply add the parameters you want to pass back in the block

```swift
        func fetchHomeFeed(completion: @escaping ([User]) -> () ) {

        Service.sharedInstance.fetchHomeFeed { (jsonUsers) in
            self.users = jsonUsers
        }
```