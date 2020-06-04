# DateFormatter

```swift
let dateFormatter = DateFormatter()
dateFormatter.dateFormat = "MMM d, yyyy"
transactionDate.text = dateFormatter.string(from: Date())
```

## DateStyle

|Style   |Output   |
|---|---|
|.full   |Wednesday, March 8, 2017   |
|.long   |March 8, 2017   |
|.medium   |Mar 8, 2017   |
|.short   |3/8/17   |
|   |   |

Example

```swift
let date = Date()
let dateFormatter = DateFormatter()
dateFormatter.dateStyle = .full
let stringOutput = dateFormatter.string(from: date)
```

### Links that help

- [DateFormatter](https://developer.apple.com/documentation/foundation/dateformatter)
- [DateStyle](https://blog.chrishannah.me/dates-and-dateformatters-in-swift/)
