# How to add private extensions to class

You can use extensions to separate code in class, or add typed selectors like this

```swift

func addButtonTargets() {
    payBillButton.addTarget(nil, action: .performPayBillAction, for: .primaryActionTriggered)
}

private extension Selector {
    static let performPayBillAction = #selector(AccountUIActions.performPayBillAction(sender:))
}

private extension ViewController {
    func commonInit() {

    }
}
```

# Extensions and Protocols

Extensions are Swift’s way to add new functionality to an existing class, structure, enumeration, or protocol type. Instead of extending a class, or implementing a protocol directly (like we did in Objective-C), in Swift you can implement protocols and add new functionality via an extension. LIke this.

```swift
extension TweetsViewController: UITableViewDataSource {
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell") as! TweetCell return cell
    }
}
```

## How to use

Typically we use extensions with protocols. We extend some type we want to add functionality to. We say what kind of functionality that is with our protocol. And then we add the implementation in our method.

```swift
extension SomeType: SomeProtocol, AnotherProtocol {
   // implementation of protocol requirements goes here
}
```

The cool thing in Swift is that we can do this not only with classes, but also with structures, enumerations, or even another protocols.

## Instance methods

You can add new functionality to existing types like this.

```swift
extension Int {
   func repetitions(task: () -> Void) {
       for _ in 0..<self {
           task()
       }
   }
}

3.repetitions {
   print("Hello!")
}
```

## Computed Properties

Add computed properties like this.

```swift
extension Double {
   var km: Double { return self * 1_000.0 }
   var m: Double { return self }
   var cm: Double { return self / 100.0 }
   var mm: Double { return self / 1_000.0 }
   var ft: Double { return self / 3.28084 }
}
```

## Initializers

Add new initializers to existing types like this.

```swift
struct Size {
   var width = 0.0, height = 0.0
}

struct Point {
   var x = 0.0, y = 0.0
}

struct Rect {
   var origin = Point()
   var size = Size()
}

extension Rect {
   init(center: Point, size: Size) {
       let originX = center.x - (size.width / 2)
       let originY = center.y - (size.height / 2)
       self.init(origin: Point(x: originX, y: originY), size: size)
   }
}

let centerRect = Rect(center: Point(x: 4.0, y: 4.0), size: Size(width: 3.0, height: 3.0))
```

## Nested Types

Created nested types like this

```swift
extension Int {
   enum Kind {
       case negative, zero, positive
   }

   var kind: Kind {

       switch self {
       case 0:
           return .zero
       case let x where x > 0:
           return .positive
       default:
           return .negative
       }
   }
}

func printIntegerKinds(_ numbers: [Int]) {

   for number in numbers {
       switch number.kind {
       case .negative:
           print("- ", terminator: "")
       case .zero:
           print("0 ", terminator: "")
       case .positive:
           print("+ ", terminator: "")
       }
   }
   print("")
}

printIntegerKinds([3, 19, -27, 0, -6, 0, 7])
// Prints "+ + - 0 - 0 + "

## Protocol Extensions

Extend protocols, and give default implementations, like this.

```swift
extension RandomNumberGenerator {
   func randomBool() -> Bool {
       return random() > 0.5
   }
}
```

## Adding Protocol Conformance with an Extension

Make any type look like any other type via an extension and a procol like this

```swift
protocol TextRepresentable {
   var textualDescription: String { get }
}
```

You can take any existing class, type, or whatever, and make it implement this protocol, simply by extending it via an extension.

```swift
extension Dice: TextRepresentable {
   var textualDescription: String {
       return "A \(sides)-sided dice"
   }
}
```

So think of extension as a way of adding new functionality, conforming to some protocol, to any type.

### Links that help

- https://docs.swift.org/swift-book/LanguageGuide/Extensions.html
- https://docs.swift.org/swift-book/LanguageGuide/Protocols.html#ID521

