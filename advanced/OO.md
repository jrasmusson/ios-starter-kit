# Object Oriented Programming

### How to pass an object type

Sometimes the client of you object needs to know a little bit more about the specifics of a particular instance, but you don't have a great way of telling it.

One way to get around this is to do what `NSNotification` does which is return a generic object (i.e. `Any`) and let the client pull out what it needs.

For example if the client of this class needs the event that goes with the article tapped, you could pass it as part of the `delegate` call back.

```swift
protocol SupportArticleViewDelegate: AnyObject {
    func didSelectArticle(withURL url: URL, withUserInfo userInfo: Any?)
}
```
And then use it in the client class like this.

```swift
func didSelectArticle(withURL url: URL, withUserInfo userInfo: Any?) {

   guard let event = userInfo as? Analytics.Actions.Activation else { return }

   let activationData: [String: AnyHashable] = [
      "supportArticleUrl": url.absoluteString
   ]

   analytics.trackEvent(withTitle: event.rawValue, context: activationData)
}
```

