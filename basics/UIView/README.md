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

## Defining objects as variables but not instantating them till later

Because of how Swift does a two phase initialization process on objects, you need to have all your properties defined before you instantiate your object. This can be a bit of a pain, as you would like your objects laid out in the order they are created without having to define earily.

One way around this is to define a dummy or empty object early, and then set the real one later during construction.

```swift
class ModemSpecificSupportView: UIView {

    // temp
    var row1 = SupportArticleRowView()
    var row2 = SupportArticleRowView()
    var row3 = SupportArticleRowView()

    init(title: String) {
        super.init(frame: .zero)
        setupViews()
    }

    func setupViews() {
        backgroundColor = .white

        // real
        row1 = makeRowView()
        row2 = makeRowView()
        row3 = makeRowView()
 ```
