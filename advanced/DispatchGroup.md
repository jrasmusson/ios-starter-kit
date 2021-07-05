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
        self.duplicationCheckGroup.wait()
        DispatchQueue.main.async {
            if !self.hasDuplicatePayment {                self.postRequest()
            }
        }
    }
}
```