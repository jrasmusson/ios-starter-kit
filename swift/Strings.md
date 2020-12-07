# Strings

## Substrings

Substrings are [tricky](https://useyourloaf.com/blog/swift-string-cheat-sheet/). You can't just subscript. You first need to get an index (type), and then use that index to pull out the substring you want.

Here is an example of how to segment a string by walking it one character at a time and breaking it into two words.

```swift
func canSegmentString(s: String, arr: [String]) -> Bool {
    for i in 0..<s.count {
        let indexStartOfText = s.index(s.startIndex, offsetBy: i)
        let indexEndOfText = s.index(s.endIndex, offsetBy: -i)
        
        let firstWord = s[..<indexStartOfText]
        let secondWord = s[indexStartOfText...]
        print("\(firstWord) \(secondWord)")
    }
    return false
}

canSegmentString(s: "applepear", arr: ["apple", "pear"])

 applepear
a pplepear
ap plepear
app lepear
appl epear
apple pear
applep ear
applepe ar
applepea r
```


## How to convert double into two decimal String for currency

On Double

```swift
extension Double {
    var clean: String {
       return self.truncatingRemainder(dividingBy: 1) == 0 ? String(format: "%.0f", self) : String(self)
    }
}
```

On FloatingPoint

```swift
extension FloatingPoint {
    var isInt: Bool {
        return floor(self) == self
    }
}

func roundPrice(price: Double) -> String {
    return price.isInt ? String(format: "%.0f", price) : String(format: "%.2f", price)
}
```



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

### How to format currency

```swift
import Foundation

public class DollarAmountValidator: TextFieldInputValidator {
    
    private struct Format {
        static let characterSet = NSCharacterSet(charactersIn: "0123456789.,")
    }
    
    let formatter = NumberFormatter()
    private let locale: Locale = Locale(identifier: "en_CA")
    
    public init() {
        formatter.maximumFractionDigits = 2
        formatter.minimumFractionDigits = 2
        formatter.minimumIntegerDigits = 1
        formatter.locale = locale
    }
    
    public func validatedString(string: String) -> String? {
        if !isValid(newNumber: string) { return nil}

        let temp = PaymentFormatter.handleFrenchKeyboard(paymentAmount: string)

        let num = NSDecimalNumber(string: temp, locale: locale)
        if num == NSDecimalNumber.notANumber { return nil }
        
        return formatter.string(from: num)
    }
    
    public func validate(editingString: String, afterReplacingCharactersInRange range: NSRange, with replacement: String) -> TextFieldInputValidation {

        guard replacement.rangeOfCharacter(from: Format.characterSet.inverted) == nil else { return .rejected }
        
        let newNumber = (editingString as NSString).replacingCharacters(in: range, with: replacement)

        if isValid(newNumber: newNumber) {
            return .accepted
        }
        
        return .rejected
    }
    
    public func isValid(newNumber: String) -> Bool {
        if newNumber.rangeOfCharacter(from: Format.characterSet.inverted) != nil { return false }

        let temp = PaymentFormatter.handleFrenchKeyboard(paymentAmount: newNumber)

        let components = temp.components(separatedBy: ".")
        if components.count > 2 { return false } // 0 or 1 decimal points

        // No more than 8 digits before decimal point
        if let first = components.first, first.count > 8 { return false }

        // No more than 2 digits after decimal point
        if let last = components.last, last.count > 2, components.count > 1 { return false }

        return true
    }
}
```

### Links that help

* [Swift Lanaguage Guide - Basics](https://docs.swift.org/swift-book/LanguageGuide/TheBasics.html)
* [Use your loaf strings](https://useyourloaf.com/blog/swift-string-cheat-sheet/)
* [Swift Strings and Characters](https://docs.swift.org/swift-book/LanguageGuide/StringsAndCharacters.html)

