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

Delete `Main storyboard file base name` entry from `Info.plist`.
