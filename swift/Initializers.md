# Initializers

Initialization is the process of preparing an instance of a class, structure, or enumeration for use. This process involves setting an initial value for each stored property on that instance and performing any other setup or initialization that is required before the new instance is ready for use.

## Private Lazy Vars

These are nice because they defer instantiation until the variable is called for the first time, after which their value is saved. So, if you call the variable for the second time, the previously saved value is returned.

```swift
    private lazy var handleView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(white: 1, alpha: 0.5)
        view.layer.cornerRadius = 3
        return view
    }()
```

## Setting Initial Values for Stored Properties

Classes and structures must set all of their stored properties to an appropriate initial value by the time an instance of that class or structure is created. Stored properties cannot be left in an indeterminate state.

```swift
struct Fahrenheit {
    var temperature: Double
    init() {
        temperature = 32.0
    }
}
```

## Assigning Constant Properities During Intialization

You can assign a value to a constant property at any point during initialization, as long as it is set to a definite value by the time initialization finishes. Once a constant property is assigned a value, it can’t be further modified.

```swift
class SurveyQuestion {
    let text: String
    var response: String?
    init(text: String) {
        self.text = text
    }
}
```

## Default Initializers

Swift provides a default initializer for any structure or class that provides default values for all of its properties and does not provide at least one initializer itself. The default initializer simply creates a new instance with all of its properties set to their default values.

```swift
class ShoppingListItem {
    var name: String?
    var quantity = 1
    var purchased = false
}
var item = ShoppingListItem()
```
 
## Delayed Assignment

Sometimes you want to assign multiple values to a variable, but some specific initialization is need on one of them. In that case just define the variable, create a newVariable, and assign it after the custom work has been done.

```swift
let viewController: UIViewController

if selectedAccount.isDefault {
    let defaultViewController = ManageAccountsViewController()
    defaultViewController.presenter = ManageAccountsPresenter(wireframe: self, session: session)
    viewController = defaultViewController
} else {
    viewController = ManageAccountsReadOnlyViewController()
}
```

## Conditional Initializer off Optional Value

Here is a way you can conditionally initialize a variable based off an optional value. The compiler is smart enough to know as long as you have it defined but not yet set it will make sure all code paths have it set a value before it is accessed later on.

```swift
    func makeLegendItem(title: String, color: UIColor? = nil, valueLabel: UILabel) -> UIView {

        var decoration: UIView
        if let color = color {
            decoration = UIView()
            decoration.backgroundColor = color
            decoration.layer.cornerRadius = LocalSpacing.dotSize/2
        } else {
            decoration = UIImageView(image: NamedImage.usageDot)
        }
```

### Links that help

* [Swift Initializers](https://docs.swift.org/swift-book/LanguageGuide/Initialization.html)


