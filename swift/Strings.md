# Strings

## How to localize Strings

First you need a localizable string file with contains all the strings for your application. And in there you put the string you want to lookup.

```swift
// Localizable.strings
"activationButton.title" = "Activate modem"; 
```

Then you could go around your app and localize all the string like this

```swift
NSLocalizedString("activationButton.title", comment: "")
```

And it would substitute your string for the one in the file. But this is annoying. So let's create a `loc` function that will simplify and do this for us.

```swift
// Localization.swift
public func loc(_ stringToLocalize: String) -> String {
    return NSLocalizedString(stringToLocalize, comment: "")
}
```

Then wherever you need to localize now you can simply call it like this.

```swift
let result = loc("activationButton.title"
```

### How to parameterize localize strings with single variable

```swift
// Localizable.strings
"activationButton.title" = "%@ support"; /* Label Title */

// Usage
title = String(format: loc("activationButton.title"), modemModel)
```

### How to parameterize localize Strings with multiple variables

If you have a string that interpolates other variables do this. Define your string with the variables like so

```swift
// Localizable.string
"activationMessage" = "Can you help me?\n Manufacturer: %1$@\n Model: %2$@\n S/N: %3$@)";
```

Then build the string with the parameters like this

```swift
let result = String.localizedStringWithFormat(NSLocalizedString("activationMessage", comment: "activation message"), manufacturer, model, serialNumber)
```


### Links that help

* [Swift Lanaguage Guide - Basics](https://docs.swift.org/swift-book/LanguageGuide/TheBasics.html)

