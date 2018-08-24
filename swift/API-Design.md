# Fundamentals
* **Clarity at the point of use** is your most important goal. Entities such as methods and properties are declared only once but used repeatedly. Design APIs to make those uses clear and concise. When evaluating a design, reading a declaration is seldom sufficient; always examine a use case to make sure it looks clear in context.
* **Clarity is more important than brevity**. Although Swift code can be compact, it is a non-goal to enable the smallest possible code with the fewest characters. Brevity in Swift code, where it occurs, is a side-effect of the strong type system and features that naturally reduce boilerplate.
* **Write a documentation comment for every declaration**. Insights gained by writing documentation can have a profound impact on your design, so don’t put it off.

> If you are having trouble describing your API’s functionality in simple terms, you may have designed the wrong API.

# Naming

* **Include all the words needed to avoid ambiguity**

```swift
extension List { 
   public mutating func remove(at position: Index) -> Element 
} 
employees.remove(at: x)
```

* **Omit needless words**

```swift
// needless words
public mutating func removeElement(_ member: Element) -> Element? allViews.removeElement(cancelButton) 

// clearer
public mutating func remove(_ member: Element) -> Element? allViews.remove(cancelButton) 
```

* **Name variables, parameters, and associated types according to their roles**

Instead of just calling a thing by its type
```swift
var string = "Hello" 
protocol ViewController { associatedtype ViewType : View } 
class ProductionLine { func restock(from widgetFactory: WidgetFactory) }
```

Name according to role like this

```swift
var greeting = "Hello" 
protocol ViewController { associatedtype ContentView : View } 
class ProductionLine { func restock(from supplier: WidgetFactory) }
```
And if something is so tightly bound to its protocol that the name is the role, avoid collision by appending type to the associated type name

```swift
protocol Sequence { 
   associatedtype IteratorType : Iterator 
}
```

* **Compensate for weak type information**

Especially when a parameter type is `NSObject`, `Any`, `AnyObject` or some fundamental type such as `Int` or `String`.

Instead of this

```swift
func add(_ observer: NSObject, for keyPath: String)
grid.add(self, for: graphics) // vague
```

Clarify what the weak type is doing more like this

```swift
func addObserver(_ observer: NSObject, forKeyPath path: String)
grid.addObserver(self, forKeyPath: graphics) // clear
```

## Strive for Fluent Usage

* **Prefer method and function names that form grammatical English phrases** 

```swift
x.insert(y, at: z)          “x, insert y at z”
x.subViews(havingColor: y)  “x's subviews having color y”
x.capitalizingNouns()       “x, capitalizing nouns”
```

* **Begin factory methods with ‘make’, e.g. `x.makeIterator()`**

* **The first argument to initializers and factory methods should not form a phrase**

Instead of this starting the first argument off with a label...
```swift
let foreground = Color(havingRGBValuesRed: 32, green: 64, andBlue: 128)
let newPart = factory.makeWidget(havingGearCount: 42, andSpindleCount: 14)
let ref = Link(to: destination)
```

Don't include the label if it's an initalizer or factory method
```swift
let foreground = Color(red: 32, green: 64, blue: 128)
let newPart = factory.makeWidget(gears: 42, spindles: 14)
let ref = Link(target: destination)
```

* **Use of Boolean methods and properties should read as assertions about the receiver**
```swift
x.isEmpty
line1.interects(line2)
```

* **Protocols that describe what something is should read as nouns e.g `Collection`**

* **Protocols that describe capability should be named using suffixes able, ible, or ing**
```swift
Equatable
ProgressReporting
```

* **Prefer to locate parameters with defaults toward the end**

## Argument Labels

```swift
func move(from start: Point, to end: Point) 
x.move(from: x, to: y)
```

* **Omit all labels when arguments can’t be usefully distinguished**
```swift
min(number1, number2)
```

* **When the first argument forms a part of a prepositional phrase (around, in, on, up, inside, as), give it an argument label**

An exception arises when the first two arguments represent parts of a single abstraction

Instead of this
```swift
a.move(toX: b, y: c)
a.fade(fromRed: b, green: c, blue: d)
```

Move the preposition out to the method so both arguments can benefit from it’s description

```swift
a.moveTo(x: b, y: c)
a.fadeFrom(red: b, green: c, blue: d)
```

Links that help
* [Swift naming guidelines](https://swift.org/documentation/api-design-guidelines/)
* [Cocoa naming guidelines](https://developer.apple.com/library/archive/documentation/Cocoa/Conceptual/CodingGuidelines/Articles/NamingMethods.html)
