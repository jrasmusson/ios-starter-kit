# Color

## System Colors

iOS has a range of system colors that automatically adapt to vibrancy and changes in accessibility setting like Increase Contrast and Reduce Transparency. The system colors look great individually and in combination, on both light and dark backgrounds, and in both like and dark modes.


<img src="https://github.com/jrasmusson/ios-starter-kit/blob/master/basics/Color/images/system-colors.png" alt="drawing" width="600"/>

<img src="https://github.com/jrasmusson/ios-starter-kit/blob/master/basics/Color/images/system-grays.png" alt="drawing" width="600"/>


## Dynamic System Colors

Apple also has semantically defined system colors for use in background areas, foreground content, and native controls like labels, seperators, and fill. They automatically adapt to both like and dark UI modes.

<img src="https://github.com/jrasmusson/ios-starter-kit/blob/master/basics/Color/images/dynamic-colors.png" alt="drawing" width="600"/>

<img src="https://github.com/jrasmusson/ios-starter-kit/blob/master/basics/Color/images/dynamic-system-color-both.png" alt="drawing" width="800"/>

<img src="https://github.com/jrasmusson/ios-starter-kit/blob/master/basics/Color/images/dynamic-stystem-background-example.png" alt="drawing" width="800"/>

<img src="https://github.com/jrasmusson/ios-starter-kit/blob/master/basics/Color/images/dynamic-system-grouped-background-example.png" alt="drawing" width="800"/>

## Programatic Color

```swift
extension UIColor {
    static let darkBlue = UIColor(red: 10/255, green: 132/255, blue: 255/255, alpha: 1)
}
```

But also give the color a name around what it represents

```swift
public extension UIColor {
    static var downloadColor: UIColor {
        return .shawSkyBlue
    }

    static var uploadColor: UIColor {
        return .shawTertiaryYellow
    }
}
```

### Links that help

- [HIG Color](https://developer.apple.com/design/human-interface-guidelines/ios/visual-design/color/)
- [Apple UI Element Colors](https://developer.apple.com/documentation/uikit/uicolor/ui_element_colors)
- [Apple Design Resources](https://developer.apple.com/design/resources/)
- [WWDC What's new in iOS](https://developer.apple.com/videos/play/wwdc2019/808/)
