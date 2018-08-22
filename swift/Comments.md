# Comments

```swift
/**
 Wait asynchronously until either the timeout has been reached, or the supplied `Capturing`
 has a result and the supplied optional capture handler block has finished executing.
 
 - warning:
 This function manages the main run loop (`NSRunLoop.mainRunLoop()`) while this function
 is executing. Any attempts to touch the run loop may cause non-deterministic behavior.

 - parameters:
    - capturing: the `Capturing` on which to wait.
    - timeout: `TimeInterval` describing how long to wait, default to 1 second.
    - resultHandler: an optional closure for inspecting the eventual captured result if it becomes available before the timeout has been reached.

 - seealso: `waitUntil(timeout:action:)` in Nimble
 */
 ```

### Links that help
* https://nshipster.com/swift-documentation/
