# How to setup a feature flag

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

Now you can change behavior in your application by changing the setting of the flag during deploy.
