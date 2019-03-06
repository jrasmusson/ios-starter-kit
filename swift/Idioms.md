# Idioms

Here are some Swift idioms that are handy when writing code.

### Nice way to return String from control in ViewController

```swift
class CreditCardDetailsViewController: UIViewController {
    var name: String { return nameField.editingText ?? "" }
    var number: String {return numberField.editingText ?? "" }
    var month: String { return monthField.text ?? "" }
    var code: String { return codeField.text ?? "" }
    var year: String { return yearField.text ?? "" }
```

### How to make type safe selectors

```swift
@objc protocol PaymentSetupUserActions {
    @objc optional func performChangeNameAction(sender: Any?)
    @objc optional func performChangePasswordAction(sender: Any?)
}

private extension Selector {
    static let performChangeNameAction = #selector(PaymentSetupUserActions.performChangeNameAction(sender:))
    static let performChangePasswordAction = #selector(PaymentSetupUserActions.performChangePasswordAction(sender:))
}
```

Then use like this

```swift
extension PaymentSetupViewController: PaymentSetupUserActions {
    func performChangeNameAction(sender: Any?) {
       // do something here...
    }
```

### Links that help

* [Swift Lanaguage Guide - Basics](https://docs.swift.org/swift-book/LanguageGuide/TheBasics.html)

