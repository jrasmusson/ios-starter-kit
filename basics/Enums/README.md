# Enums

## Examples

```swift
class Tile {
    enum StatusState {
        case loading
        case loaded
        case failed
        case delinquent
    }
    
    var status: StatusState {
        didSet {
            switch status {
            case .loading: loadingState.isHidden = false
            case .loaded: loadedState.isHidden = false
            case .failed: failedState.isHidden = false
            case .delinquent: delinquentState?.isHidden = false
            }
        }
    }
}
```

```swift
enum Character {
    enum Weapon {
        case bow
        case sword
        case dagger
    }

    enum Helmet {
        case wooden
        case iron
        case diamond
    }

    case thief(weapon: Weapon, helmet: Helmet)
    case warrior(weapon: Weapon, helmet: Helmet)

    func getDescription() -> String {
        switch self {
        case let .thief(weapon, helmet):
            return "Thief chosen \(weapon) and \(helmet) helmet"
        case let .warrior(weapon, helmet):
            return "Warrior chosen \(weapon) and \(helmet) helmet"
        }
    }
}

let helmet = Character.Helmet.iron
print(helmet)
//prints "iron"

let character1 = Character.warrior(weapon: .sword, helmet: .diamond)
print(character1.getDescription())
// prints "Warrior chosen sword and diamond helmet"
```

```swift
open class NetworkReachabilityManager {
    public enum NetworkReachabilityStatus {
        case unknown
        case notReachable
        case reachable(ConnectionType)
    }

    public enum ConnectionType {
        case ethernetOrWiFi
        case wwan
    }

    // MARK: - Properties

    open var isReachable: Bool { return isReachableOnWWAN || isReachableOnEthernetOrWiFi }
    open var isReachableOnWWAN: Bool { return networkReachabilityStatus == .reachable(.wwan) }
    open var isReachableOnEthernetOrWiFi: Bool { return networkReachabilityStatus == .reachable(.ethernetOrWiFi) }
    
    open var networkReachabilityStatus: NetworkReachabilityStatus {
        return .unknown
    }
```

## Enums in structs

And this is where deciding what to make a enum and what to make a struct can blur. For example we could define a character purely as an enum like this

```swift
enum Character {
    enum Weapon {
        case bow
        case sword
        case dagger
    }
    case thief(weapon: Weapon)
    case warrior(weapon: Weapon)

let character1 = Character.warrior(weapon: .sword)
```

But we could also represent a Character as a struct like this.

```swift
struct Character {
    enum CharacterType {
        case thief
        case warrior
    }
    enum Weapon {
        case bow
        case sword
        case dagger
    }
    let type: CharacterType
    let weapon: Weapon
}

let character = Character(type: .warrior, weapon: .sword)
print("\(character.type) chosen \(character.weapon)")
```

What’s the difference? In the first case the Charact type information is captured as part of the enum itself. So you define it purely in terms of enums like this

```swift
let character1 = Character.warrior(weapon: .sword)
```

In the struct case, you define the same internal enums, but the top high level enum is defined as a struct, which stores the enums it uses inside as stored properties.

Which one you use is a matter of style and circumstance. If you can get away with purely defining everything in terms of enums, the pure enum method would be an option as this is extemely light weight, and requires little to no overhead.

If you think your character needs more data in the form of storied properties, or you want to start adding more functionality and state, the struct would be the way to go. A bit heavier. But still very light. 

At this point I don’t have any strong opinions. Try them both and see what you like.

## Enums as Strings

With Swift, enums don’t have to be just integers. We can also represent enums as Strings.

```swift
enum SegueIdentifier: String {
    case Login
    case Main
    case Options
}

// or

enum EmployeeType: String {
    case Executive
    case SeniorManagement = "Senior Management"
    case Staff
}
```

The beauty of the String, is you no longer need to have hard coded Strings spread throughout your library. You can now capture those as enum types and switch on them very conveniently.

```swift
override func prepareForSegue(...) {
    if let identifier = segue.identifier ... {
        switch segueIdentifier {
        case .Login:
            ...
        case .Main:
            ...
        case .Options:
            ...
        }
    }
    
    SequeIdentifer.Main.rawValue // returns the `String representation`
}
```

## Enums and associated values

Enums are so much more in Swift, because just when you thought they couldn’t get any better, you learn you can also associated values or parameters with enums too.

```swift
enum Barcode {
    case upc(Int, Int, Int, Int)
    case qrCode(String)
}
```

This enum above can take a tuple of values, or associated types with it. I actually don’t like this form of enum, because it doesn’t tell me what the associated values are. I think something like this is much better.

```swift
public class StandardEntryView: UIView {
    
    public enum Kind {
        case email(showHeaderView: Bool)
        case listSelection(showHeaderView: Bool, pickerTitle: String, list: [(String, Any)])
    }

    public let kind: Kind

    public init(kind: Kind = Kind.email(showHeaderView: false)) {
        self.kind = kind
        super.init(frame: .zero)
        commonInit()
    }
```

Here we have a UIView that can be in one of two states: email, and listSelection. But along with each of these states, we can pass additional information or associated values.

This means our enums can not have state! This definitely blurs the lines between traditional enums as mere types representing intergers, and this new enum in Swift. Because now in Swift, we can construct these enums, associate with this additional types of objects, and then use that information when we switch on them later. Like this.

```swift
func commonInit() {

        let showHeader: Bool

        switch kind {
        case .email(let showHeaderView): // unwrapping the associated value
            showHeader = showHeaderView
        case .listSelection(let showHeaderView, _, _):
            showHeader = showHeaderView
        }

    }
```

This ability to pass information with the enum is really cool, and something Swift supports. And if you don’t care about the associated values passed, you can ignore them entirely.

```swift
switch kind {
        case .email:
            textField = UITextField()
        case .listSelection:
            textField = NoCaratNoTypingTextField()
        }
```

Or selectively

```swift
switch kind {
        case .email:
            break
        case .listSelection(_, let pickerTitle, let listItems):
            break
        }
```

Enums with methods

```swift
enum WeekDay :String {
    case Monday
    case Tuesday
    func day() ->String { return self.rawValue }
}
print(WeekDay.Monday.day()) // prints Monday
```

Now this is really taking enums to a whole new level. You now have the ability to add methods to enums. These are definitely blurring classes, objects, and structs with enums. But enums are so cheap, they are a nice alternative. Again, for things that naturally represent state.


## Enums with Computed Properties

```swift
enum Device {
  case iPad
  case iPhone

  var year: Int {
    switch self {
      case .iPhone: 
        return 2007
      case .iPad: 
        return 2010
    }
  }
}

let device = Device.iPhone
print(device.year)
```

Note enums can’t have stored properties. In other ways you can’t do this.

```swift
enum Device {
  case iPad
  case iPhone

  var year: Int // BOOM!
}
```

## Enums with mutating methods

Enums by themselves have no state. But you can simulate, or toggle an enums state by having it mutate itself. By creating a mutating function that can set the implicit self parameter, use can change the state of the referenced enum itself.

```swift
enum TriStateSwitch {
    case off
    case low
    case high
    mutating func next() {
        switch self {
        case .off:
            self = .low
        case .low:
            self = .high
        case .high:
            self = .off
        }
    }
}

var ovenLight = TriStateSwitch.off
ovenLight.next() // ovenLight is now equal to .low
ovenLight.next() // ovenLight is now equal to .high
ovenLight.next() // ovenLight is now equal to .off again
```

This is really cool because it’s like a state machine within itself.

## Enums with static methods

```swift
enum Device {
    case iPhone
    case iPad

    static func getDevice(name: String) -> Device? {
        switch name {
        case "iPhone":
            return .iPhone
        case "iPad":
            return .iPad
        default:
            return nil
        }
    }
}

if let device = Device.getDevice(name: "iPhone") {
    print(device)
    //prints iPhone
}
```

## Enums with initializers

```swift
enum IntCategory {
    case small
    case medium
    case big
    case weird

    init(number: Int) {
        switch number {
        case 0..<1000 :
            self = .small
        case 1000..<100000:
            self = .medium
        case 100000..<1000000:
            self = .big
        default:
            self = .weird
        }
    }
}

let intCategory = IntCategory(number: 34645)
print(intCategory)
```

## Enums and Protocols

Again, blurring the line between enum and struct, but if you want an enum to confirm to a protocol, you can do it like this.

```swift
protocol LifeSpan {
    var numberOfHearts: Int { get }
    mutating func getAttacked() // heart -1
    mutating func increaseHeart() // heart +1
}

enum Player: LifeSpan {
    case dead
    case alive(currentHeart: Int)

    var numberOfHearts: Int {
        switch self {
        case .dead: return 0
        case let .alive(numberOfHearts): return numberOfHearts
        }
    }

    mutating func increaseHeart() {
        switch self {
        case .dead:
            self = .alive(currentHeart: 1)
        case let .alive(numberOfHearts):
            self = .alive(currentHeart: numberOfHearts + 1)
        }
    }

    mutating func getAttacked() {
        switch self {
        case .alive(let numberOfHearts):
            if numberOfHearts == 1 {
                self = .dead
            } else {
                self = .alive(currentHeart: numberOfHearts - 1)
            }
        case .dead:
            break
        }
    }
}

var player = Player.dead // .dead

player.increaseHeart()  // .alive(currentHeart: 1)
print(player.numberOfHearts) //prints 1

player.increaseHeart()  // .alive(currentHeart: 2)
print(player.numberOfHearts) //prints 2

player.getAttacked()  // .alive(currentHeart: 1)
print(player.numberOfHearts) //prints 1

player.getAttacked() // .dead
print(player.numberOfHearts) // prints 0
```

## Enums and Extensions

Enums can have extensions, and this is handy for when you want to separate your data structs from your methods.

Note the mutating keyword. Any time you want to modify the state of an enum, a mutating method definition is needed.

```swift
enum Entities {
    case soldier(x: Int, y: Int)
    case tank(x: Int, y: Int)
    case player(x: Int, y: Int)
}

extension Entities {
    mutating func attack() {}
    mutating func move(distance: Float) {}
}

extension Entities: CustomStringConvertible {
    var description: String {
        switch self {
        case let .soldier(x, y): return "Soldier position is (\(x), \(y))"
        case let .tank(x, y): return "Tank position is (\(x), \(y))"
        case let .player(x, y): return "Player position is (\(x), \(y))"
        }
    }
}
```

## Enums as generics

Yes, you can even generize enums.

```swift
enum Information<T1, T2> {
    case name(T1)
    case website(T1)
    case age(T2)
}
```

Here the compiler is able to recognize T1 as ‘Bob’, but T2 is not defined yet. Therefore, we must define both T1 and T2 explicitly as shown below.

```swift
let info = Information.name("Bob") // Error

let info =Information<String, Int>.age(20)
print(info) //prints age(20)
```

## Other misc things

### Enums as guards

Another example of how enums can be used in with guard statements.

```swift
enum ChatType {
    case authenticated
    case unauthenticated
}

class NewChatViewController: UIViewController {

    let chatType: ChatType

    public init(chatType: ChatType) { ... }

    guard chatType == .authenticated else {
        return
    }
```

### Iterating over enums

```swift
enum Beverage: CaseIterable {
    case coffee, tea, juice
}
let numberOfChoices = Beverage.allCases.count

for beverage in Beverage.allCases {
    print(beverage)
}
```

### Enums as Errors

```swift
public enum AFError: Error {

    case invalidURL(url: URLConvertible)
    case parameterEncodingFailed(reason: ParameterEncodingFailureReason)
    case multipartEncodingFailed(reason: MultipartEncodingFailureReason)
    case responseValidationFailed(reason: ResponseValidationFailureReason)
    case responseSerializationFailed(reason: ResponseSerializationFailureReason)

    public enum ParameterEncodingFailureReason {
        case missingURL
        case jsonEncodingFailed(error: Error)
        case propertyListEncodingFailed(error: Error)
    }

    public var underlyingError: Error? {
        switch self {
        case .parameterEncodingFailed(let reason):
            return reason.underlyingError
        case .multipartEncodingFailed(let reason):
            return reason.underlyingError
        case .responseSerializationFailed(let reason):
            return reason.underlyingError
        default:
            return nil
        }
    }

}

extension AFError {
    /// Returns whether the AFError is an invalid URL error.
    public var isInvalidURLError: Bool {
        if case .invalidURL = self { return true }
        return false
    }
}
```

## Enums and versions

Say you have a backend service where the type is represented as an enum, and you want to future proof it for when new types come later. Create an `Unknown` versions and set that as the enum type if you can't decode it from the JSON.

```swift
enum AccountSubType: String, Codable {
    case Chequing
    case Saving
    case Unknown
}

extension AccountSubType {
    init(from decoder: Decoder) throws {
        self = try Self(rawValue: decoder.singleValueContainer().decode(RawValue.self)) ?? Self.Unknown
    }
}
```

## Is there anything enums can’t do?

Yes. Enums don’t support stored properties.

In other words you can’t do this

```swift
enum Device {
  case iPad
  case iPhone

  var year: Int
}
```
### How to add an enum to an existing struct

Say you want to have a struct return an enum based on an internal type.

```swift
enum ActivationModemType: String {
    case hayes
    case usRobotics
    case unknown
}

struct OrderItem {
    let modemType: String
}

extension OrderItem {
    // computed getter
    public var activationModemType: ActivationModemType {
        guard let modemType = modemType, let returnValue = ActivationModemType(rawValue: modemType) else {
            return ActivationModemType.unknown
        }
        return returnValue
    }
```

You use the internal variable (`modemType`) to dynamically figure out the enum in the computed getter, and then return that enum value.

### Enums can be used as types

Enums don't just have to be used for switch statements. They, along with their associated values, can be more more akin to objects and structures themselves. For example here is an example of how a struct where one of it's types is an Enum.

```swift

import Foundation

struct ActivationResourcePackage {
    let headerImageName: String
    let list: [ListType]
}

enum ListType {
    case checkmark(header: String, subheader: String)
    case url(title: String, url: URL)
    case appDownload(title: String, subheader: String, buttonTitle: String, appUrl: URL)
}

extension ActivationResourcePackage {
    static var usRoboticsPackage = ActivationResourcePackage(headerImageName: "robot-pink", list: [
        ListType.checkmark(header: "Pat your head", subheader: "This helps the intertubes do their magic."),
        ])

    static var hayesPackage = ActivationResourcePackage(headerImageName: "robot-pink", list: [
        ListType.checkmark(header: "Rub your belly", subheader: "Getting hungry for that internet goodness!"),
        ListType.checkmark(header: "That's it!", subheader: "Don't forget to have a good day."),
        ])
}
```

What you are signalling here is I want you to create an object for me, based on this enum and all it's associated data. It's a compact way of sending a lot of state and type information, conveniently in one package.

```swift
private func createPackage(for orderItem: OrderItem) -> ActivationResourcePackage {

    switch orderItem.activationModemType {
    case .usRobotics:
        return ActivationResourcePackage.usRoboticsPackage
    case .hayes:
        return ActivationResourcePackage.hayesPackage
    case .unknown:
        return ActivationResourcePackage.unKnowPackage
    }

}
```

Here we are creating a type safe package representing our configuration, based on an enum type.

### How to convert a string into an enum

```swift
enum ActivationModemType: String {
    case hayes
    case usRobotics
    case unknown
}
let modem = ActivationModemType(rawValue: "usRobotics")
```

## Links that help

- [Apple Swift Docs](https://docs.swift.org/swift-book/LanguageGuide/Enumerations.html)
- [More Enum Examples](https://developerinsider.co/advanced-enum-enumerations-by-example-swift-programming-language/)


