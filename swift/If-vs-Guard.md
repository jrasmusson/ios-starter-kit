# If vs Guard

## Examples

If you have something `Optional` define one variable with a default value, then another to unwrap, and in the unwrapping reassign the default value one if need be.

```swift
    func modemSpecificSupportViewTitle() -> String {
        var title = "Modem specific support"

        if let modemModel = OrderDetailsService.sharedInstance.modemModel?.capitalizingFirstLetter() {
            title = "\(modemModel) specific support"
        }

        return title
    }
```

## What's the difference?

Swift if-let and guard statements are two tools we have for safely wrapping  Optionals.

If-let takes the current variable, and by assigning it to self, unwraps the Optional and makes it available within the scope of the if.

```swift
if let x = someOptional {
    // use unwrapped x
} else {
    // x is nil
}
```

Guard on the other hand does the same thing only when the variable is wrapped, it is available for use outside the guard clause.

```swift
guard let x = someOptional {
    // leave scope
}
// use unwrapped x
```

# When to use if-let

Use `if-let` when you want to check an unsafe operation for safety, before assigning it's output to a variable. For example here we want to make sure we only assign `NSUserDefaults` to our array if they already exist.

```swift
var array: [String]?
let defaults = UserDefaults.standard
    
override func viewDidLoad() {
    super.viewDidLoad()

    if let items = defaults.array(forKey: "Array") as? [String] {
        array = items
    }
```


The mechanics here are to create a new temp variable first, and then assign it to the old on success.

```swift
var array: [String]?
    
if let temp = someOptional
    array = temp
}
```

They other way to use `if-let` is to let a variable safely unwrap itself, then use it for some other assignment.

```swift
let x: Int? = nil
var name: String?

if let x = x {
    name = "namex"
} else {
    name = "namey"
}
```


# When to use guard-let

I use guard all the time because it reads so much better. It’s like a soft assert. “If this variable isn’t here and doesn’t have a value, through an assert and let me know that my program is about to crash because some variable isn’t in a state that it needs to be.

Here as some examples of guard.

```swift
guard let image = UIImage(named: selectedImageName) else {
    preconditionFailure("Missing \(selectedImageName)")
}

guard let account = session.selectedAccount else { 
    fatalError("attempt to pay bill w/o an account") 
}
```
What I like about the guard is it's scope (you can use it outside the guard clause) and how much simpler it reads.

Note: if-let and guard-let statements also work for if-var and guard-var. Use var is you expect your variable to change over the course of the method. Else stick with the let.

# Guards in loops

One thing to be wary of is how guards function in loops. When a guard clause evaluates to else in a loop, you need to transfer control with a “break” or “continue”. Saying it another way, in functions you would normally “return” from a guard, but in a loop you need to “break or continue” (note: you never “break” or “continue” from a function).

This example demonstrates this.

![Example of looping with guard break](https://github.com/jrasmusson/ios-starter-kit/blob/master/swift/images/guard-break.png)

![Example of looping with guard continue](https://github.com/jrasmusson/ios-starter-kit/blob/master/swift/images/guard-continue.png)



# Guard clause examples

```swift

// assert this is true - else don't continue
guard !bankAccountRadioButton.isOn else { return }

// if this is true... continue with program
guard possibleError == nil else {
    // else come in here and do this
    return
}
 
// if is empty (double negative)
guard !decodedData.results.isEmpty else {
    return postError(.appStoreDataRetrievalEmptyResults)
}

guard Bundle.bundleID() != nil else {
    printMessage("Please make sure that you have set a `Bundle Identifier` in your project.")
    return
}

// this is hard to read - would have used regular if
guard isAppStoreVersionNewer() else {
     delegate?.sirenLatestVersionInstalled()
     postError(.noUpdateAvailable)
     return
}
            
func validateFieldsAndContinueRegistration() {
    
    guard let firstNameString = firstName.text where firstNameString.characters.count > 0 else {
        firstName.becomeFirstResponder()
        return
    }
    
    // all text fields have valid text
    let accountModel = AccountModel()
    accountModel.firstName = firstNameString

   APIHandler.sharedInstance.registerUser(accountModel)
}

```

### Links that help
* [if-let vs guard-let](https://medium.com/@mimicatcodes/unwrapping-optional-values-in-swift-3-0-guard-let-vs-if-let-40a0b05f9e69)
