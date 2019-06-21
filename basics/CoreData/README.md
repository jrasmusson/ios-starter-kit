# CoreData

## Fetching Results

Say you have an entity name `Company`. You can fetch results like this.

```swift
    func fetchCompanies() {
        // initialization
        let persistentContainer = NSPersistentContainer(name: "IntermediateTrainingModels")
        persistentContainer.loadPersistentStores { (storeDescription, error) in
            if let error = error {
                fatalError("Loading of store failed \(error)")
            }
        }

        let context = persistentContainer.viewContext

        let fetchRequest = NSFetchRequest<Company>(entityName: "Company")

        do {
            let companies = try context.fetch(fetchRequest)
            companies.forEach { (company) in
                print(company.name ?? "")
            }
        } catch let fetchError {
            print("Failed to fetch companies: \(fetchError)")
        }

    }
```

## CRUD

New Single View Application with CoreData added.

```swift
//
//  AppDelegate.swift
//  myDevices
//
//  Created by Jonathan Rasmusson (Contractor) on 2019-06-19.
//  Copyright © 2019 Jonathan Rasmusson. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.

        addTestData()
        retrieveData()
        updateData()
        retrieveData()
        deleteData()
        retrieveData()

        return true
    }

    func addTestData() {
        guard let entity = NSEntityDescription.entity(forEntityName: "Device", in: persistentContainer.viewContext) else {
            fatalError("Could not find entity description!")
        }

        for i in 1...1 {
            let device = NSManagedObject(entity: entity, insertInto: persistentContainer.viewContext)
            device.setValue("name\(i)", forKey: "name")
            device.setValue(i % 3 == 0 ? "Watch" : "iPhone", forKey: "deviceType")
        }
    }

    func retrieveData() {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Device")

        do {
            let result = try persistentContainer.viewContext.fetch(fetchRequest)
            for data in (result as? [NSManagedObject])! {
                let name = data.value(forKey: "name") as! String
                let device = data.value(forKey: "deviceType") as! String

                print("\(name) and \(device)")
            }
        } catch {
            print("Error fetching")
        }
    }

    func updateData() {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Device")
        fetchRequest.predicate = NSPredicate(format: "name = %@", "name1")

        do {
            let result = try persistentContainer.viewContext.fetch(fetchRequest)

            let objectToUpdate = result[0] as! NSManagedObject
            objectToUpdate.setValue("newName", forKey: "name")

            do {
                try persistentContainer.viewContext.save()
            } catch {
                print(error)
            }
        } catch {
            print(error)
        }
    }

    func deleteData() {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Device")
        fetchRequest.predicate = NSPredicate(format: "name = %@", "newName")

        do {
            let result = try persistentContainer.viewContext.fetch(fetchRequest)

            let objectToDelete = result[0] as! NSManagedObject
            persistentContainer.viewContext.delete(objectToDelete)

            do {
                try persistentContainer.viewContext.save()
            } catch {
                print(error)
            }
        } catch {
            print(error)
        }
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        // Saves changes in the application's managed object context before the application terminates.
        self.saveContext()
    }

    // MARK: - Core Data stack

    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
        */
        let container = NSPersistentContainer(name: "myDevices")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                 
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support

    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }

}
```

## Generated Classes

Now this is fine, but to give us some additional type safety CoreData lets you generated classes off of your data model. 

If you run the generator on your data model (`Editor > Create NSManageObject Subclass...`) Xcode will generate the following files for you.

A class for you to do your customization and helpers.

```swift
import Foundation
import CoreData

@objc(Device)
public class Device: NSManagedObject {

}
```

And an extension for it to autogenerated its APIs.

```swift
import Foundation
import CoreData

extension Device {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Device> {
        return NSFetchRequest<Device>(entityName: "Device")
    }

    @NSManaged public var deviceType: String?
    @NSManaged public var name: String?

}
```

Except that if you do this you will get an error. As Xcode already does this for you (Xcode 10) and you will get a duplication produce file error.

Not clear what the right way to do this yet is. But know that you have type safety with CoreData classes, which Xcode automatically creates, that let's you do your CoreData operations in a more type safe way like this.

```swift
    func addTestData() {
        guard let entity = NSEntityDescription.entity(forEntityName: "Device", in: persistentContainer.viewContext) else {
            fatalError("Could not find entity description!")
        }

        for i in 1...1 {
            let device = NSManagedObject(entity: entity, insertInto: persistentContainer.viewContext)
            device.setValue("name\(i)", forKey: "name")
            device.setValue(i % 3 == 0 ? "Watch" : "iPhone", forKey: "deviceType")
        }
    }

    func retrieveData() {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Device")

        do {
            let result = try persistentContainer.viewContext.fetch(fetchRequest)
            for device in (result as? [Device])! {
                let name = device.name
                let device = device.deviceType

                print("\(String(describing: name)) and \(String(describing: device))")
            }
        } catch {
            print("Error fetching")
        }
    }

    func updateData() {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Device")
        fetchRequest.predicate = NSPredicate(format: "name = %@", "name1")

        do {
            let result = try persistentContainer.viewContext.fetch(fetchRequest)

            let deviceToUpdate = result[0] as! Device
            deviceToUpdate.name = "newName"

            do {
                try persistentContainer.viewContext.save()
            } catch {
                print(error)
            }
        } catch {
            print(error)
        }
    }

    func deleteData() {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Device")
        fetchRequest.predicate = NSPredicate(format: "name = %@", "newName")

        do {
            let result = try persistentContainer.viewContext.fetch(fetchRequest)

            let deviceToDelete = result[0] as! Device
            persistentContainer.viewContext.delete(deviceToDelete)

            do {
                try persistentContainer.viewContext.save()
            } catch {
                print(error)
            }
        } catch {
            print(error)
        }
    }
```



### Links that help

* [CRUD example](https://medium.com/@ankurvekariya/core-data-crud-with-swift-4-2-for-beginners-40efe4e7d1cc)
