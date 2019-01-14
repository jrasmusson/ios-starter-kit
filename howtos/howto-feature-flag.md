# Feature flags

## Environment variable

One way to setup a feature flag or toggle is to create an environment variable

<img src="https://github.com/jrasmusson/ios-starter-kit/blob/master/howtos/images/environment-variable.png" />

And then call it like this

```swift
var url: String = {

        if ProcessInfo.processInfo.environment["MOCK_API"] == "YES" {
            return "http://localhost:8000/orderDetails/"
        }

        return "https://prod/orderDetails"
}()
```

Environment variable only work on the simulator and locally connected devices. To create a feature flag that will work into production we need a compile time flag.

## Conditional Compilation Block

Compile time flags are setup up in configuration files (xcconfig). You define you compile time flag in there like this

```swift
_DD_SIMULATOR[sdk=*simulator*] = BUILDING_FOR_SIMULATOR
```

And then use it like this.

```swift
func isFeatureAvailable() -> Bool {
    #if BUILDING_FOR_SIMULATOR
        return false
    #else
        return true
    #endif
}
```

<img src="https://github.com/jrasmusson/ios-starter-kit/blob/master/howtos/images/custom-flags.png" />


### Links that help
- [Conditional Compilation Block - Swift](https://docs.swift.org/swift-book/ReferenceManual/Statements.html)
