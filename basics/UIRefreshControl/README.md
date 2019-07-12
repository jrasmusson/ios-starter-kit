# UIRefresh

```swift

   override func viewDidLoad() {
		...
       handleDownload()
    }
    
    func handleDownload() {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(handleRefresh), for: .valueChanged)
	refreshControl.tintColor = .white
		
        self.refreshControl = refreshControl
    }

    @objc func handleRefresh() {
        Service.shared.downloadCompaniesFromServer()
	
	// Dismiss the refresh control
        DispatchQueue.main.async {
            self.refreshControl?.endRefreshing()
        }

    }
```
![TableView](https://github.com/jrasmusson/ios-starter-kit/blob/master/basics/UIRefreshControl/images/demo.gif)

