# DispatchGroup

A way of grouping network calls so they occur as a group, and also signally other parts not to proceed until the group completes.

For example, say we want to check that duplicate payments don't exist before a user clicks send. DispatchGroup would help us here like this.

```swift
class ViewController: UIViewController {

   var duplicationCheckGroup = DispatchGroup()
   
   func checkDuplicate() {
      self.duplicationCheckGroup.enter() // enter
      self.fetchTransfers() // network call {
         self.duplicationCheckGroup.leave() // leave
      }
   }
   
   @IBAction func send(_ sender: UIButton) {
    DispatchQueue.global(qos: .default).async {
        // wait the duplication check result
        self.duplicationCheckGroup.wait() // wait
        DispatchQueue.main.async {
            if !self.hasDuplicatePayment {                
               self.postRequest()
            }
        }
    }
}
```

## Notify

Another nice trick is to notify another part of the code when a network call completes.

Here we don't present the view controller until the fetch function completes.

```swift
    private func handleLoginError(...) {

        let group = DispatchGroup()
        group.enter() // enter
        DispatchQueue.main.async {
            fetchAccountHolderName { model, error in
                group.leave() // leave
            }
        }


        switch error {
        case .start:
            group.notify(queue: .main) { // notify
                let welcomeVC = WelcomeViewController()
                ...
            }
```



