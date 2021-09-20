# How dispatch main queue

## With delay

```swift
DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(delay)) {
	// delayed main thread
}
```

## Getting on the main thread

We always want to be rendering and updating components on the main UI thread. That includes all UITable reloads() and calculations from delegates.

One way to do that that always happens, is when you call a long lived asynchronous operation, make sure you put the competion block your return back on the main thread.

For example if we make a asynchronous network call like this

ViewController

```swift
   func fetchData() {
        Service.shared.fetchCourses { (courses, err) in

            self.tableView.reloadData() // want to make sure on main thread!
        }
    }
```

We can make sure the callback is put onto the main thread like this

Services

```swift
class Service: NSObject {
    static let shared = Service()
    
	func fetchCourses(completion: @escaping ([Course]?, Error?) -> ()) {
	
	    // network call... parsing ...
	    DispatchQueue.main.async {
	        completion(courses, nil)
	    }
	}
}
```

You can do it here, or in the ViewController. Doesn't really matter. So long as you do it.

## Links that help

- [Building Concurrent Interfaces in UI - WWDC 2012](https://developer.apple.com/videos/play/wwdc2012/211/)
