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

Which every way you go, remember to make your protocol reference `weak` in your delegate class. This will avoid any cyclmatic references in your code.



## Links that help
* https://medium.com/@abhimuralidharan/all-about-protocols-in-swift-11a72d6ea354
* https://docs.swift.org/swift-book/LanguageGuide/Protocols.html


