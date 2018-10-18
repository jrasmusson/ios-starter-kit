# How setup project with no storyboards

```swift
    private func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        window?.rootViewController = ViewController()

        return true
    }
```

Delete the storyboard from the project.

Then delete the keyword `Main` from project `Deployment Info` `Main Interface` section under the General Project Tab.

<img src="https://github.com/jrasmusson/ios-starter-kit/blob/master/howtos/images/deployment-info.png" alt="drawing" width="800"/>

Delete `Main storyboard file base name` entry from `Info.plist`.

Then instantiate your `ViewController` in `AppDelegate`.
