# Protocols & Delegates

An example.

```swift
protocol LogoDownloaderDelegate: AnyObject {
    func didFinishDownloading(_ sender:LogoDownloader)
} 

class LogoDownloader {

    weak var delegate: LogoDownloaderDelegate?
    
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

## Naming

There is a definite convention around naming your protocol methods. Start the name of your protocol with the name of the sender, followed by the state of the thing that changed. 

```swift
sender / state that changed
```

For example here we return the switch of the button followed by the state after. 

```swift
protocol InternetTileViewControllerDelegate: AnyObject {
    func internetTileViewController(_ viewController: InternetTileViewController, didSetInternetPackage package: InternetPackage?)
}

protocol SavedPaymentSectionViewDelegate: AnyObject {
    func savedPaymentInfoSwitch(_ infoSwitch: CheckBoxButton, didChange state: Bool)
    func savePaymentInfoButtonWasTapped(_ infoButton: UIButton)
}
```

If there is no state change, include the action with the sender in the name. Here is another.

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

## Class only protocol in Swift 4

You used to use the keyword `class` but now the preferred way to do class based protocols is with `AnyObject`.

```swift
protocol DetailViewControllerDelegate: AnyObject {
  func didFinishTask(sender: DetailViewController)
}
```

## Button target action

```swift
button.addTarget(self, action: #selector(buttonPressed(_:)), for: .primaryActionTriggered)

@objc func buttonPressed(_ sender: UIButton) {
delegate?.headerViewDelegate(self, didChange: 0)
}
```


## Links that help
* https://medium.com/@abhimuralidharan/all-about-protocols-in-swift-11a72d6ea354
* https://docs.swift.org/swift-book/LanguageGuide/Protocols.html


