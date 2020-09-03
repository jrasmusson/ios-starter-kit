# Kind

A nice use of enums for differentiating two different configrations in the same view.

```swift
class RequirementsView: UIView {
    enum Kind {
        case register
        case download
    }

    var kind: Kind = .download
}

var ctaText: String? {
        switch kind {
        case .register:
            return NSLocalizedString("Register", comment: "")
        case .download:
            return NSLocalizedString("Download", comment: "")
        }
    }
```


# Gotchas

Never assume reference the first element in an array with `0`. 

```swift
guard let hardware = subscription.hardware[0] else { // BOOM! - Don't do this
    return
}
```
Use `first` instead.
```swift
guard let hardware = subscription.hardware.first else { // Safe - nil return guard fails gracefully
    return
}
```

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

Then get some nice readable type safe extensions for your ViewController by implementing the protocol.

```swift
extension PaymentSetupViewController: PaymentSetupUserActions {
    func performChangeNameAction(sender: Any?) {
       // do something here...
    }
```

## Always check the main thread before popping alert when error handling

```swift
// Once you've created the builder, pass it to the sfmc_configure method.
do {
    try MarketingCloudSDK.sharedInstance().sfmc_configure(with:builder)
    success = true
} catch let error as NSError {
    // Errors returned from configuration will be in the NSError parameter and can be used to determine
    // if you've implemented the SDK correctly.

    let configErrorString = String(format: "MarketingCloudSDK sfmc_configure failed with error = %@", error)
    print(configErrorString)

    DispatchQueue.main.async {
        let alert = UIAlertController(title: "Configuration Error", message: configErrorString, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.window?.topMostViewController()?.present(alert, animated: true)
    }
}
```

### Links that help

* [Swift Lanaguage Guide - Basics](https://docs.swift.org/swift-book/LanguageGuide/TheBasics.html)

