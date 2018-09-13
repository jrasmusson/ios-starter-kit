# How setup project with no storyboards

Delete the storyboard from the project.

Delete the keyword `Main` from project `Deployment Info` `Main Interface` section.

<img src="https://github.com/jrasmusson/ios-starter-kit/blob/master/howtos/images/deployment-info.png" alt="drawing" width="400"/>

Delete `Main storyboard file base name` entry from `Info.plist`.

Then instantiate your `ViewController` in `AppDelegate`.

```swift
func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
    
    window = UIWindow(frame: UIScreen.main.bounds)
    window?.makeKeyAndVisible()
    
    let navigatorController = UINavigationController(rootViewController: ViewController())
    window?.rootViewController = navigatorController
    
    return true
}
```

