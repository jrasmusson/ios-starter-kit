# Theads

## How to get on the background thread

```swift
DispatchQueue.global(qos: .background).async {

}

```
## How to get back onto the main thread

Do this if you ever get a warning or error saying that you shouldn't be doing this action while not on the main thread.

```swift
DispatchQueue.main.async { [unowned self] in
    self.tableView.reloadData()
}
```
