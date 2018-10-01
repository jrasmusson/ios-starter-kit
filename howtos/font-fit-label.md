# How reduce font size to fit label

Do this when you have text that is exceeding the bounds of the label, but you would like it to fit.

```swift
    func makeLabel() -> UILabel {

        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.font = UIFont.systemFont(ofSize: 17)
        
        label.adjustsFontSizeToFitWidth = true // reduce font to fit label
        label.minimumScaleFactor = 0.5 // smallest acceptable font size 

        return label
    }
```
