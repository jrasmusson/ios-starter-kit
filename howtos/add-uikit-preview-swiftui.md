# How to add UIKit preview to Swift UI


```swift
#if canImport(SwiftUI) && DEBUG
import SwiftUI

@available(iOS 13, *)
struct ActivationFooterViewPreview: PreviewProvider {

    static var previews: some View {
        UIViewPreview {
            let view = ActivationFooterView(activationResourcePackage: HitronActivationData().activationPackage)

            return view
        }
        .previewLayout(.fixed(width: 320.0, height: 100.0))
        .padding(10)
    }
}
#endif
```

- [Link](https://nshipster.com/swiftui-previews/)