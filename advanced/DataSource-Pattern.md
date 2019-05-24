# The DataSource Pattern

One very popular Cocoa pattern you see a lot in iOS (i.e. `UITableViewDataSource`) is the Data Source pattern. It's handy, because it lets you create an object and instiate it, and then populate it with data after (like somewhere else in the code once an asychronous call has been completed).

For example say early on in the lifecycle of the app we get an `accessToken` and our network class needs access to it later. We can setup the data source on the access token early, and have it ready for when the class is really needed.

Here is how it works.

### Step 1: Define the DataSource

Here we define a `protocol` representing the API for setting our datasource. In this example we want to retrieve an `accessToken`.

```swift
protocol OrderDetailsServiceDataSource: AnyObject {
    var accessToken: String? { get }
}
```

Then we create a `weak var` representing that in our class for later when we really need it. The `weak` is needed to avoid a potential retain cycle.

```swift
weak var dataSource: OrderDetailsServiceDataSource?
```

Then when we need `accessToken` we can simply get it from our datasource like this.

```swift
guard let accessToken = dataSource?.accessToken else {
            assertionFailure("No access token")
            return
        }
```

### Step 2: Make the your source class conform to new datasource.

Now say the struct holding my access token looks like this.

```swift
struct BearerToken {
    let accessToken: String
}

class MyAccountSession {
    var bearerToken: BearerToken

    init(bearerToken: BearerToken) {
        self.bearerToken = bearerToken
    }
}
```

The problem here is that my `MyAccountSession` class doesn't expose the `accessToken`. It is hidden inside `BearerToken`. The way I can open it up is to make the `MyAccountSession` implement my new `OrderDetailsServiceDataSource` protocol. And we can do that in an extension like this.


```swift
extension MyAccountSession: OrderDetailsServiceDataSource {

    var accessToken: String? {
        return tokenAuthentication.bearerToken?.accessToken
    }
    
}

```

### Step 3: Set the datasource on the object.

Now with everything set, all we need to do is set the data source with the access token when the app starts up. Something like this in the `AppDelegate`.

```swift
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        let bearerToken = BearerToken(accessToken: "foobar")
        let session = MyAccountSession(bearerToken: bearerToken)

        OrderDetailsService.sharedInstance.dataSource = session

        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        window?.rootViewController = ViewController()

        return true
    }
```

### Step 4: Use it

Now when you ask for the datasource in your network API class, you will have it because it will have already been set.

```swift
guard let accessToken = dataSource?.accessToken else {
    assertionFailure("No access token")
    return
}
```

<img src="https://github.com/jrasmusson/ios-starter-kit/blob/master/advanced/images/datasource-pattern.png" alt="drawing" width="400"/>

#### Full Source

```swift
//
//  OrderDetailsService.swift
//  DataSourcePattern
//
//  Created by Jonathan Rasmusson on 2018-12-18.
//  Copyright © 2018 Jonathan Rasmusson. All rights reserved.
//

struct OrderDetails: Codable {
    let serialNumber: String?
}

// protocol must be class based to support the weak var
protocol OrderDetailsServiceDataSource: AnyObject {
    var accessToken: String? { get }
}

class OrderDetailsService {

    static let sharedInstance = OrderDetailsService()

    // important! weak else potential retain cycle
    weak var dataSource: OrderDetailsServiceDataSource?

    var url = "http://localhost:3000/order_details/1.json"

    func fetchOrderDetails(completion: @escaping (OrderDetails?, Error?) -> Void ) {

        guard let accessToken = dataSource?.accessToken else {
            assertionFailure("No access token")
            return
        }

        let headers: Dictionary = [
            "Authorization": "Bearer \(accessToken)"
        ]

        // network call...
        print("accessToken: \(accessToken)")
    }

}

//
//  MySession.swift
//  DataSourcePattern
//
//  Created by Jonathan Rasmusson (Contractor) on 2018-12-18.
//  Copyright © 2018 Jonathan Rasmusson. All rights reserved.
//

import Foundation

struct BearerToken {
    let accessToken: String
}

class MyAccountSession {
    var bearerToken: BearerToken

    init(bearerToken: BearerToken) {
        self.bearerToken = bearerToken
    }
}

extension MyAccountSession: OrderDetailsServiceDataSource {

    var accessToken: String? {
        return bearerToken.accessToken
    }

}


//
//  ViewController.swift
//  DataSourcePattern
//
//  Created by Jonathan Rasmusson (Contractor) on 2018-12-18.
//  Copyright © 2018 Jonathan Rasmusson. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        OrderDetailsService.sharedInstance.fetchOrderDetails { (orderDetails, error) in
            
        }
    }
}

//
//  AppDelegate.swift
//  DataSourcePattern
//
//  Created by Jonathan Rasmusson (Contractor) on 2018-12-18.
//  Copyright © 2018 Jonathan Rasmusson. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        let bearerToken = BearerToken(accessToken: "foobar")
        let session = MyAccountSession(bearerToken: bearerToken)

        OrderDetailsService.sharedInstance.dataSource = session

        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        window?.rootViewController = ViewController()

        return true
    }
}
