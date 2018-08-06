# Protocols and Parameterization

This is a useful technique for when you have objects that are hard to testing at runtime, but you would like to write a test that uses them.

Say for example you have an document viewer app that looks like this

<img src="https://github.com/jrasmusson/ios-starter-kit/blob/master/testing/protocols/images/app.png" alt="demo" width="250px"/>

And the you want to test that loads the document looks like this

```swift
@IBAction func openTapped(_ send: Any) {
  let mode: String
  switch segmentControl.selectedSegmentIndex {
  case 0: mode = "view"
  case 1: mode = "edit"
  default: fatalError("Impossible case")
  }
  let url = URL(string: "myaascheme://open?id=\(document.identifier)&mode==\(mode)")!
  
  if UIApplication.shared.canOpenURL(url) {
    UIApplication.shared.open(url, options: [:], completionHandler: nil)
  } else {
    handleURLError()
  }

```

Now the first problem is that we have a lot of logic embedded in our ViewController. So we don't we pull that out first.

```swift
class DocumentOpener {
  enum OpenMode: String {
    case view
    case edit
  }
  func open(_ document: Document, mode: OpenMode) {
    let modeString = mode.rawValue
      let url = URL(string: "myaascheme://open?id=\(document.identifier)&mode==\(mode)")!
  
    if UIApplication.shared.canOpenURL(url) {
      UIApplication.shared.open(url, options: [:], completionHandler: nil)
    } else {
      handleURLError()
    }
  }
}

```

Now this is an improvement, but what we really want is to extract that class that is hard to test - `UIApplication`. So let's make it a variable and dependence inject that into our class.

```swift
class DocumentOpener {
  let application: UIApplication
  init(application: UIApplication) {
    self.application = application
  }
  
  /* ... */
}
```

```swift
  /* ... */
 func open(_ document: Document, mode: OpenMode) {
    let modeString = mode.rawValue
      let url = URL(string: "myaascheme://open?id=\(document.identifier)&mode==\(mode)")!
  
    if application.shared.canOpenURL(url) {
      application.shared.open(url, options: [:], completionHandler: nil)
    } else {
      handleURLError()
    }
  }
}  
```

And now we can start stubbing out our unit test like this

```swift
funct testDocumentOpenerWhenItCanOpen() {
  let app = /* ??? */
  let opener = DocumentOpener(application: app)
  
  
}
```

Now if you look at the methods on `UIApplication` that we are about there are two: `canOpenURL` and `open`. These we can turn into a protocol.

```swift
protocol URLOpening {
  func canOpenURL(_ url: URL) -> Bool
  func open(_ url: URL, options: [String: Any], completionHandler: ((Bool) -> Void)?)
}
```

The beaty of this that that we can now apply this protocol to the `UIApplication` itself. And it won't need to do anything because it already implements the protocol.

```swift
protocol URLOpening {
  func canOpenURL(_ url: URL) -> Bool
  func open(_ url: URL, options: [String: Any], completionHandler: ((Bool) -> Void)?)
}

extension UIApplication: URLOpening {
  // Nothing needed here!
}
```

Our `DocumentOpener` class can now use this protocol instead of the actual `UIApplication` class. So we can go from this

```swift
class DocumentOpener {
  let application: UIApplication
  init(application: UIApplication) {
    self.application = application
  }
  
  /* ... */
}
```

to this

```swift
class DocumentOpener {
  let urlOpener: URLOpening
  init(application: URLOpening = UIApplicaiton.shared) {
    self.urlOpener = urlOpener
  }
  
  /* ... */
}
```

Not also how we assign the default real implementation in the initializer.

And now we can use it in the rest of the application like this.

```swift
  /* ... */
 func open(_ document: Document, mode: OpenMode) {
    let modeString = mode.rawValue
      let url = URL(string: "myaascheme://open?id=\(document.identifier)&mode==\(mode)")!
  
    if urlOpener.canOpenURL(url) {
      application.open(url, options: [:], completionHandler: nil)
    } else {
      handleURLError()
    }
  }
}  
}
```

Now we can create a `MockURLOpener` and fill it with some tracking variables and some defaults.

```swift
class MockURLOpener: URLOpening {
  var canOpen = false
  var openedURL: URL?
  
  func canOpenURL(_ url: URL) -> Bool {
    return canOpen
  }
  
  func open(_ url: URL, options: [String: Any], completionHandler: ((Bool) -> Void)?) {
  openedURL = url
}
}
```

And then use in our our real test code this is.

```swift
func testDocuementOpenerWIthItCanOpen() {
  let urlOpener = MockURLOpener()
  urlOpener.canOpen = true
  let documentOpener = DocumentOpener(urlOpener: urlOpener)
  
  document.open(Document(identifier: "TheID"), mode: .edit)
  
  XCTAssertEqual(urlOpener.openedURL, URL(string: "Myappscheme://open?id=TheID&mode=edit))
}
```



### Links that help

* [Engineering for Testability - WWDC 2017](https://developer.apple.com/videos/play/wwdc2017/414)

