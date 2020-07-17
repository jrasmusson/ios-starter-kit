# CoreData

## Example

```swift
//
//  CoreDataManager.swift
//  CoreDataDemo
//
//  Created by Jonathan Rasmusson (Contractor) on 2020-03-02.
//  Copyright © 2020 Jonathan Rasmusson. All rights reserved.
//

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

    func createEmployee(name: String) -> Employee? {
        let context = persistentContainer.viewContext
        let employee = NSEntityDescription.insertNewObject(forEntityName: "Employee", into: context) as! Employee

        employee.name = name

        do {
            try context.save()
            return employee
        } catch let createError {
            print("Failed to create: \(createError)")
        }

        return nil
    }

    func fetchEmployees() -> [Employee]? {
        let context = persistentContainer.viewContext

        let fetchRequest = NSFetchRequest<Employee>(entityName: "Employee")

        do {
            let employees = try context.fetch(fetchRequest)
            return employees
        } catch let fetchError {
            print("Failed to fetch companies: \(fetchError)")
        }

        return nil
    }

    func fetchEmployee(withName name: String) -> Employee? {
        let context = persistentContainer.viewContext

        let fetchRequest = NSFetchRequest<Employee>(entityName: "Employee")
        fetchRequest.fetchLimit = 1
        fetchRequest.predicate = NSPredicate(format: "name == %@", name)

        do {
            let employees = try context.fetch(fetchRequest)
            return employees.first
        } catch let fetchError {
            print("Failed to fetch: \(fetchError)")
        }

        return nil
    }

    func updateEmployee(employee: Employee) {
        let context = persistentContainer.viewContext

        employee.name = "Peter"

        do {
            try context.save()
        } catch let createError {
            print("Failed to update: \(createError)")
        }
    }

    func deleteEmployee(employee: Employee) {
        let context = persistentContainer.viewContext
        context.delete(employee)

        do {
            try context.save()
        } catch let saveError {
            print("Failed to delete: \(saveError)")
        }
    }

}
```

```swift
import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        RunCoreData()
    }

    func RunCoreData() {
        // Create
        guard let newEmployee = CoreDataManager.shared.createEmployee(name: "Jon") else { return }

        // Read
        guard let employee = CoreDataManager.shared.fetchEmployee(withName: "Jon") else { return }
        guard let employees = CoreDataManager.shared.fetchEmployees() else { return }

        // Update
        CoreDataManager.shared.updateEmployee(employee: employee)
        guard let updatedEmployee = CoreDataManager.shared.fetchEmployee(withName: "Jon") else { return }

        // Delete
        CoreDataManager.shared.deleteEmployee(employee: updatedEmployee)
    }
}
```

### How to add CoreData to project from scratch

- Go new DataModel > MyData.xcdatamodeld
- Click Add Entity (Employee)
- Give it a name
- Add your attributes
- Make non-optional (RHS - but not Swift Optional)
- Build / Clean / Restart Xcode
- You can now access (Employee) entity in your viewController.

    Note
     - All attributes in CoreData are Optional


### Checklist

- Relationship directions
- Cascading deletes (top down but not bottom up)

### Links that help

- [CoreData Attributes](https://developer.apple.com/documentation/coredata/modeling_data/configuring_attributes?language=objc)
- [Live Cycle Managed Object](https://developer.apple.com/library/archive/documentation/Cocoa/Conceptual/CoreData/LifeofaManagedObject.html)
- [Parsing JSON background thread](https://developer.apple.com/library/archive/documentation/Cocoa/Conceptual/CoreData/Concurrency.html#//apple_ref/doc/uid/TP40001075-CH24-SW1)
