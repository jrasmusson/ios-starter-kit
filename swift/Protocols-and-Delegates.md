# Protocols & Delegates

There's a couple of ways to do this. One is to just define your protocol method by what it does and return self.

```swift
protocol LogoDownloaderDelegate {
    func didFinishDownloading(_ sender:LogoDownloader)
} 

class LogoDownloader {

    weak var delegate:LogoDownloaderDelegate?
    
    func downloadLogo() {
    	delegate?.didFinishDownloading(self)
    }
    
} 

extension ViewController: LogoDownloaderDelegate {

    override func viewDidLoad() {
        logoDownloader?.delegate = self
    }
    
    func didFinishDownloading(_ sender: LogoDownloader) {
    } 
}

```

The other is to start your protocol method names with the name of your class.

```swift

protocol FileImporterDelegate: AnyObject {
    func fileImporter(_ importer: FileImporter,
                      shouldImportFile file: File) -> Bool

    func fileImporter(_ importer: FileImporter,
                      didAbortWithError error: Error)

    func fileImporterDidFinish(_ importer: FileImporter)
}

class FileImporter {
    weak var delegate: FileImporterDelegate?
}
```

And some, like `UITableView` use a combination of each. Naming convention is `ClassDelegate` or `ClassDataSource`.

```swift
protocol UITableViewDataSource : NSObjectProtocol {

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell

    func numberOfSections(in tableView: UITableView) -> Int // Default is 1 if not implemented

}

class UITableView : UIScrollView, NSCoding, UIDataSourceTranslating {
	weak open var dataSource: UITableViewDataSource?
}
```

Which every way you go, remember to make your protocol reference `weak` in your delegate class. This will avoid any cyclomatic references and retains cycles in your code.



## Links that help
* https://medium.com/@abhimuralidharan/all-about-protocols-in-swift-11a72d6ea354
* https://docs.swift.org/swift-book/LanguageGuide/Protocols.html


