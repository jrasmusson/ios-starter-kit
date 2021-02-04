# How to app time out inactivity

Here is a simply way to detect inactivity in an application and react accordingly.

The magic line is this one here:

```swift
    override func sendEvent(_ event: UIEvent)
```

It can intercept incoming events for the entire application. Which you must then dispatch up via the super and then handle your own way after.

**MyApplication.swift**

```swift
class MyApplication: UIApplication {
    static let timeoutDuration: TimeInterval = 5
    private var idleTimer: Timer?
    
    override init() {
        super.init()
        // Iniitlize timer
        resetTimer()
    }

    override func sendEvent(_ event: UIEvent) {
        super.sendEvent(event)

        if let touches = event.allTouches {
            for touch in touches where touch.phase == .began {
                resetTimer()
            }
        }
    }

    // MARK: - Idle Timer
    private func resetTimer() {
        DispatchQueue.main.async {
            self.idleTimer?.invalidate()
            self.idleTimer = Timer.scheduledTimer(timeInterval: MyApplication.timeoutDuration,
                                                  target: self,
                                                  selector: #selector(self.timerTriggered),
                                                  userInfo: nil,
                                                  repeats: true)
        }
    }

    @objc private func timerTriggered() {
        NotificationCenter.default.post(name: .appTimedOut, object: nil)
    }
}

extension NSNotification.Name {
    static let appTimedOut = NSNotification.Name("AppTimedOut")
}
```

**main.swift**

```swift
import UIKit

UIApplicationMain(
    CommandLine.argc,
    CommandLine.unsafeArgv,
    NSStringFromClass(MyApplication.self),
    NSStringFromClass(AppDelegate.self)
)
```
