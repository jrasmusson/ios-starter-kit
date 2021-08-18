# DispatchGroup

## Notify

Say we don't want to reload the table view, until all three `fetchGame` requests complete.

```swift
fetchGame("1")
fetchGame("2")
fetchGame("3")
```

By creating a `DispatchGroup` and calling `enter` and `leave` before and after each call.

```swift
let group = DispatchGroup()

func fetchGame(_ id: String) {
        group.enter()
        
        URLSession.shared.dataTask(with: url) { (data, res, err) in
            self.group.leave()
        }.resume()
}
```

The dispatch group will notify us when all three calls have completed, enabling us to then reload on the table.

```swift
group.notify(queue: .main) {
    self.tableView.reloadData()
}
```

### Example

```swift
import UIKit

struct Game: Codable {
    var id: String
    var name: String
}

class ViewController: UIViewController {
    var games: [Game] = []
    var tableView = UITableView()
    let group = DispatchGroup()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
        view = tableView
        
        fetchGame("1")
        fetchGame("2")
        fetchGame("3")
        
        group.notify(queue: .main) {
            print("Complete")
            self.tableView.reloadData()
        }
    }
    
    func fetchGame(_ id: String) {
        print("foo - Enter")
        group.enter()
        
        let url = URL(string: "https://fierce-retreat-36855.herokuapp.com/game/\(id)")!
        URLSession.shared.dataTask(with: url) { (data, res, err) in
            guard err == nil, let data = data else { return }
            do {
                let game = try JSONDecoder().decode(Game.self, from: data)
                self.games.append(game)
                print("foo - Leave")
                self.group.leave()
                
//                DispatchQueue.main.async {
//                    self.tableView.reloadData() // incremental
//                }
                
            } catch let err {
                print(err)
            }
        }.resume()
    }
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = games[indexPath.row].name
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return games.count
    }
}
```

It's handy for those cases where you 

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

## Wait

A way of grouping network calls so they occur as a group, and only proceeding when the group completes.

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


### Links that help

- [Simple example](https://riptutorial.com/ios/example/28278/dispatch-group)
- [Good video](https://www.youtube.com/watch?v=OanfpW0H_ok&ab_channel=maxcodes)
