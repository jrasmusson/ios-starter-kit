# UIView

## Custom constructor

When creating a custom view, all non-optional variables have to be initialized before you call `super`.

	“Swift’s compiler performs four helpful safety-checks to make sure that two-phase initialization is completed without error:”

	Safety check 1 “A designated initializer must ensure that all of the “properties introduced by its class are initialized before it delegates up to a superclass initializer.”	

```swift
class ModemSpecificSupportView: UIView {

    let title: String

    init(title: String) {
        self.title = title

        super.init(frame: .zero)

        setupViews()
        fetchArticles()
    }
```

