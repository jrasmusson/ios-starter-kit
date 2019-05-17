# Testing with callbacks

Say you have some code in your ViewController that looks something like this.

```swift
    override func viewDidAppear(_ animated: Bool) {

        defer {
            NewChatViewController.havePromptedUserForNotifications = true
        }

        switch (notificationManager.operatingSystemPromptStatus, NewChatViewController.havePromptedUserForNotifications)  {
        case (NotificationPermissionPromptStatus.notShown, false):
            showNotificationScreen()
        case (NotificationPermissionPromptStatus.shownAndDenied, false):
            showNotificationAlert()
        default:
            return
        }
    }
```

And you would like to write a unit test without Mocking and stubbing. One way to do it is to exact this logic into a struct, and make the method calls you would like it to make callbacks.

```swift

public enum NotificationPermissionPromptStatus: Int {
    case unknown, notShown, shownAndDenied, shownAndAccepted
}

struct ChatNotifier {
    let notificationPermissionPromptStatus: NotificationPermissionPromptStatus

    let notShownHandler: () -> Void
    let shownAndDeniedHandler: () -> Void

    static var havePromptedUserForNotifications = false

    func notify() {
        defer {
            ChatNotifier.havePromptedUserForNotifications = true
        }

        switch (notificationPermissionPromptStatus, ChatNotifier.havePromptedUserForNotifications) {
        case (NotificationPermissionPromptStatus.notShown, false):
            notShownHandler()
        case (NotificationPermissionPromptStatus.shownAndDenied, false):
            shownAndDeniedHandler()
        default:
            return
        }
    }
}
```

Then you can write unit test like this.

```swift
import Nimble
import Quick

@testable import xxx
@testable import yyy

class ChatNotifierSpec: QuickSpec {

    var chatNotifier: ChatNotifier!

    override func spec() {

        // Setup
        var notificationShown = false
        var alertShown = false

        func showScreen() {
            notificationShown = true
        }

        func showAlert() {
            alertShown = true
        }

        describe("when checking to see if user has been prompted for notifications") {

            context("and user has never been show the notification prompt") {

                beforeEach {
                    notificationShown = false
                    alertShown = false

                    let chatNotifier = ChatNotifier(notificationPermissionPromptStatus: NotificationPermissionPromptStatus.notShown,
                                                    notShownHandler: showScreen,
                                                    shownAndDeniedHandler: showAlert)
                    chatNotifier.call()
                }

                it("should show screen") {
                    expect(notificationShown).to(equal(true))
                }

                it("should not show alert") {
                    expect(alertShown).to(equal(false))
                }
            }

            context("and user has been shown and denied") {

                beforeEach {
                    notificationShown = false
                    alertShown = false

                    let chatNotifier = ChatNotifier(notificationPermissionPromptStatus: NotificationPermissionPromptStatus.shownAndDenied,
                                                    notShownHandler: showScreen,
                                                    shownAndDeniedHandler: showAlert)
                    chatNotifier.call()
                }

                it("should not show screen") {
                    expect(notificationShown).to(equal(false))
                }

                it("should show alert") {
                    expect(alertShown).to(equal(true))
                }
            }
        }
    }
}
```

