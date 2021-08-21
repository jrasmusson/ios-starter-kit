# DispatchGroup

Handy class for grouping related calls together and not proceeding until they complete.

Two typical use cases are:

- Notify - how to be notified when a group of network calls complete
- Wait - how to wait for a group of actions to complete before proceeding

## Notify

![](images/notify.png)

```swift
// MARK: DispatchGroup
extension ViewController {
    private func fetchData() {
        let group = DispatchGroup()
        
        group.enter()
        fetchProfile { optionalProfile in
            guard let profile = optionalProfile else { return }
            self.profileLabel.text = profile.name
            group.leave()
        }

        group.enter()
        fetchEntitlement { optionalEntitlement in
            guard let entitlement = optionalEntitlement else { return }
            self.entitlementLabel.text = entitlement.access
            group.leave()
        }

        group.enter()
        fetchPreference { optionalEntitlement in
            guard let entitlement = optionalEntitlement else { return }
            self.preferenceLabel.text = entitlement.vehicle
            group.leave()
        }

        group.notify(queue: .main) {
            self.loginButton.isEnabled = true
        }
    }
}
```

## Wait




### Links that help

- [Simple example](https://riptutorial.com/ios/example/28278/dispatch-group)
- [Good video](https://www.youtube.com/watch?v=OanfpW0H_ok&ab_channel=maxcodes)
