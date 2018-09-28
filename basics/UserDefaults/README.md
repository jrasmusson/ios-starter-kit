# UserDefaults

```swift

        if UserDefaults.standard.bool(forKey: "OnboardingHasBeenViewed") {
			  ...
            return
        }

        UserDefaults.standard.set(true, forKey: "OnboardingHasBeenViewed")
```




