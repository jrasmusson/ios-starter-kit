# Feature flags

## Environment flags

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

## Compile time flags

Compile time flags are setup up in configuration files (xcconfig) or as a `Swift Compiler - Custom Flag`.

### Swift Compiler - Custom Flag

Target > Build Settings then search for 'Swift Compiler - Custom'.

<img src="https://github.com/jrasmusson/ios-starter-kit/blob/master/howtos/images/custom-flags.png" />

Here you set a flag on the `Active Compilation Condition` for each of your targets by double clicking the row (i.e. Debug) and where is says `<Multiple Values>` you add your new flag (i.e. `FOO`).

<img src="https://github.com/jrasmusson/ios-starter-kit/blob/master/howtos/images/compile-flag-foo.png" />

You can then access the flag at runtime like this

```swift
func isFeatureAvailable() -> Bool {
    #if FOO
        return false
    #else
        return true
    #endif
}
```

Note: In older versions of Xcode and projects you will still see the old `Other Swift Flags` section. Where here you add a compile time flag per line. Also, these properties often are read in from configuration files (`.xcconfig`).

<img src="https://github.com/jrasmusson/ios-starter-kit/blob/master/howtos/images/compile-flag-old-flag.png" />

And then still access the same way

```swift
#if MOCK_API
    return URL(string: "https://mock")
#else
    return URL(string: "https://prod")
#endif
```




### Links that help
- [Conditional Compilation Block - Swift](https://docs.swift.org/swift-book/ReferenceManual/Statements.html)
- [Sundell Feature Flags in Swift](https://medium.com/@johnsundell/feature-flags-in-swift-e99b11f5ca57)
