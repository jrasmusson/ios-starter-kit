# Left / Right Swipe Animation

![TableView](https://github.com/jrasmusson/ios-starter-kit/blob/master/animations/images/demo-InteractiveAnimations.gif)

This example shows how to swipe left/right on button presses using `UIViewController` `add/remove` functionality. Core of demo is how viewControllers are added and removed.

<img src="https://github.com/jrasmusson/ios-starter-kit/blob/master/howtos/images/turn-off-debug-console.png" alt="drawing" width="400"/>

```swift
    @objc func button1Pressed() {
        if container.children.first == viewControllers[0] { return }

        // 1. Add
        container.add(viewControllers[0])

        // 2. Animate
        animateTransition(fromVC: viewControllers[1], toVC: viewControllers[0]) {success in
            // 3. Remove
            self.viewControllers[1].remove()
        }
    }
```

We basically look for button presses in our tabBar viewController, and then add > animate > remove viewControllers appropriately.


### Links that help
* [Sundell Container View](https://www.swiftbysundell.com/articles/custom-container-view-controllers-in-swift/)
