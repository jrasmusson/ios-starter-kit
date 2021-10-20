# SFSymbols

## How to set scale

```swift
let configuration = UIImage.SymbolConfiguration(scale: .large)
let symbolImage = UIImage(systemName: "square.and.pencil", withConfiguration: configuration)

imageView.image = symbolImage
```

## How to change color

```swift
let chevronImage = UIImage(systemName: "chevron.right")!.withTintColor(.systemTeal, renderingMode: .alwaysOriginal)
chevonImageView.image = chevronImage
```
