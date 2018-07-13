Swift if-let and guard statements are two tools we have for safely wrapping  Optionals.

If-let takes the current variable, and by assigning it to self, unwraps the Optional and makes it available within the scope of the if.

```swift
if let x = x {
    // use unwrapped x
} else {
    // x is nil
}
```

Guard on the other hand does the same thing only when the variable is wrapped, it is available for use outside the guard clause.

```swift
guard let x = x {
    // leave scope
}
// use unwrapped x
```

# When to use if
Do be honest, I don’t have many good examples of when one would use if-let over guard. One way I try to rationalize it is like this. Use if-let for the case where the Optional could be an acceptable or OK value. Think of if-let as: “If I have a real value here for this Optional, do this. Else do this.

```swift
If let x = x {
 // use unwrapped x
} else {
 // set x to some default value
 return “foo”
}
```

While this may be find for variables that have a very limited life-span, I find this quite useless. Why would I have to work with a variable only in the scope of the if statement? For me the much better construct is the guard.

# When to use guard

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



# Guard clause in action

Here is an example of how a guard clause does does validation on all the required fields for signing up a new user. If any of the guard clauses fail, the text field is given focus (becomeFirstResponder) and the method simply returns control to the user to fill in the missing information.

```swift
func validateFieldsAndContinueRegistration() {
    
    guard let firstNameString = firstName.text where firstNameString.characters.count > 0 else {
        firstName.becomeFirstResponder()
        return
    }

    guard let lastNameString = lastName.text where lastNameString.characters.count > 0 else {
        lastName.becomeFirstResponder()
        return
    }

    guard let emailNameString = emailName.text where emailNameString.characters.count > 3 else {
        emailName.becomeFirstResponder()
        return
    }

    guard let passwordString = password.text where passwordString.characters.count > 7 else {
        password.becomeFirstResponder()
        return
    }
    
    // all text fields have valid text
    let accountModel = AccountModel()
    accountModel.firstName = firstNameString
    accountModel.lastName = lastNameString
    accountModel.email = emailString
    accountModel.password = passwordString
    APIHandler.sharedInstance.registerUser(accountModel)
}
```

Links that help
* [if-let vs guard-let](https://medium.com/@mimicatcodes/unwrapping-optional-values-in-swift-3-0-guard-let-vs-if-let-40a0b05f9e69)




