# UITextView

## How to left justify multiline text

![Dismiss keyboard](https://github.com/jrasmusson/ios-starter-kit/blob/master/basics/UITextView/images/multiline.png)

```swift
func makeChatTextView(text: String) -> UITextView {
    let textView = UITextView()
    textView.translatesAutoresizingMaskIntoConstraints = false
    textView.font = UIFont.systemFont(ofSize: 16)
    textView.textColor = .gray
    textView.textAlignment = .left
    textView.text = text
    textView.textContainer.lineFragmentPadding = 0
    textView.textContainerInset = .zero

    return textView
}
```

The last two lines get rid of the extra padding you get by default.

```swift
    textView.textContainer.lineFragmentPadding = 0
    textView.textContainerInset = .zero
```

And you autolayout it out just like any other element pinning it to the left and right sides. Note: You also need to give it an explicity height (else ambiguous). Use in `UIViewContoller` like this.

```swift
func setupViews() {
    let chatText = makeChatTextView(text: "Visit our support library to discover how to troubleshoot issues and learn about your account")
    
    addSubview(chatText)

    chatText.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 24).isActive = true
    chatText.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -24).isActive = true
    chatText.topAnchor.constraint(equalTo: chatTitle.bottomAnchor, constant: 8).isActive = true
    chatText.heightAnchor.constraint(equalToConstant: 100).isActive = true // important!
}
```

### Links that help
* [How to get rid of extra padding](https://medium.com/@lawrey/swift-4-align-textview-with-uilabel-66dbc97c91c9)
