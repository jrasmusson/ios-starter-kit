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

## Non-breaking hyphen

```swift
let nonBreakingHyphen = "\u{2011}"
subtitle: "Interac e\(Constants.nonBreakingHyphen)Transfer®",
```

### Links that help

* [Swift Lanaguage Guide - Basics](https://docs.swift.org/swift-book/LanguageGuide/TheBasics.html)
* [Use your loaf strings](https://useyourloaf.com/blog/swift-string-cheat-sheet/)
* [Swift Strings and Characters](https://docs.swift.org/swift-book/LanguageGuide/StringsAndCharacters.html)

