# Object Oriented Programming

### Loose coupling

Sometimes when writing software, the client of your library wants to pass something in, but you don't really want to know what they thing is.

For example you may have a view that you want to return a specific event on. But by passing in the event you are coupling to it. You basically have three options.

```swift
// 1. Couple to the event -> Coupling
func didSelectArticle(withURL url: URL, analyticsEvent: Analytics.Actions.Activation) {

// 2. Pass in `Any` -> Must cast `Any` to specific type in client
func didSelectArticle(withURL url: URL, analyticsEvent: Any?) {

// 3. Use a generic -> No casting required
func didSelectArticle(withURL url: URL, analyticsEvent: T) {
```

The problem with #1 is you introduce hard coupling into your API. Now you library need to know about event.

The problem with #2 is you decouple, but they you need a cast in the client to convert `Any` into whatever object you want.

#3 is the right way to go because with generics, no casting is required.

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

