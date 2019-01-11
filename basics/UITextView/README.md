# UITextView

## How to left justify multiline text

`UITextView` is like `UILabel` and `UITextField` but unlike label and text field, is better at displaying multiline text.

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

### Links that help
* [How to get rid of extra padding](https://medium.com/@lawrey/swift-4-align-textview-with-uilabel-66dbc97c91c9)
