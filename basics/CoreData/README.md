# CoreData

## Example

```swift
import UIKit
import CoreData

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        RunCoreData()
    }

    func RunCoreData() {

        // Create
        guard let newChannel = CoreDataManager.shared.createChannel(number: "1") else { return }

        // Read
        guard let channel = CoreDataManager.shared.fetchChannel(withNumber: "1") else { return }
        guard let channels = CoreDataManager.shared.fetchChannels() else { return }

        // Update
        CoreDataManager.shared.updateChannel(channel: channel)
        guard let updatedChannel = CoreDataManager.shared.fetchChannel(withNumber: "2") else { return }

        // Delete
        CoreDataManager.shared.deleteChannel(channel: updatedChannel)
    }

}
```

```swift
import CoreData

struct CoreDataManager {

    static let shared = CoreDataManager()

    let persistentContainer: NSPersistentContainer = {

        let container = NSPersistentContainer(name: "MyData")
        container.loadPersistentStores { (storeDescription, error) in
            if let error = error {
                fatalError("Loading of store failed \(error)")
            }
        }

        return container
    }()

    func createChannel(number: String) -> Channel? {
        let context = persistentContainer.viewContext
        let channel = NSEntityDescription.insertNewObject(forEntityName: "Channel", into: context) as! Channel

        channel.number = number

        do {
            try context.save()
            return channel
        } catch let createError {
            print("Failed to create: \(createError)")
        }

        return nil
    }

    func fetchChannels() -> [Channel]? {
        let context = persistentContainer.viewContext

        let fetchRequest = NSFetchRequest<Channel>(entityName: "Channel")

        do {
            let channels = try context.fetch(fetchRequest)
            return channels
        } catch let fetchError {
            print("Failed to fetch companies: \(fetchError)")
        }

        return nil
    }

    func fetchChannel(withNumber number: String) -> Channel? {
        let context = persistentContainer.viewContext

        let fetchRequest = NSFetchRequest<Channel>(entityName: "Channel")
        fetchRequest.fetchLimit = 1
        fetchRequest.predicate = NSPredicate(format: "number == %@", number)

        do {
            let channels = try context.fetch(fetchRequest)
            return channels.first
        } catch let fetchError {
            print("Failed to fetch: \(fetchError)")
        }

        return nil
    }

    func updateChannel(channel: Channel) {
        let context = persistentContainer.viewContext

        channel.number = "2"

        do {
            try context.save()
        } catch let createError {
            print("Failed to update: \(createError)")
        }
    }

    func deleteChannel(channel: Channel) {
        let context = persistentContainer.viewContext
        context.delete(channel)

        do {
            try context.save()
        } catch let saveError {
            print("Failed to delete: \(saveError)")
        }
    }

}
```

### How to add CoreData to project from scratch

- Go new DataModel > MyData.xcdatamodeld
- Click Add Entity (Channel)
- Give it a name
- Add your attributes
- Make non-optional (RHS - but not Swift Optional)
- Build / Clean / Restart Xcode
- You can now access (Channel) entity in your viewController.

    Note
     - All attributes in CoreData are Optional
     - 


### Checklist

- Relationship directions
- Cascading deletes (top down but not bottom up)

### Links that help

- [CoreData Optionalaity](https://developer.apple.com/documentation/coredata/modeling_data/configuring_attributes?language=objc)
- [Live Cycle Managed Object](https://developer.apple.com/library/archive/documentation/Cocoa/Conceptual/CoreData/LifeofaManagedObject.html)
