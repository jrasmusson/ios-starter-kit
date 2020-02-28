# CoreData

## Example

```swift
import CoreData

struct CoreDataManager {

    static let shared = CoreDataManager()

    let persistentContainer: NSPersistentContainer = {

        let container = NSPersistentContainer(name: "IntermediateTrainingModels")
        container.loadPersistentStores { (storeDescription, error) in
            if let error = error {
                fatalError("Loading of store failed \(error)")
            }
        }

        return container
    }()

    func fetchCompanies() -> [Company] {
        let context = persistentContainer.viewContext

        let fetchRequest = NSFetchRequest<Company>(entityName: "Company")

        do {
            let companies = try context.fetch(fetchRequest)
            return companies
        } catch let fetchError {
            print("Failed to fetch companies: \(fetchError)")
        }

        return []
    }

    func createEmployee(employeeName: String, employeeType: String, birthday: Date, company: Company) -> (Employee?, Error?) {
        let context = persistentContainer.viewContext
        let employee = NSEntityDescription.insertNewObject(forEntityName: "Employee", into: context) as! Employee

        employee.name = employeeName
        employee.type = employeeType
        employee.company = company

        let employeeInformation = NSEntityDescription.insertNewObject(forEntityName: "EmployeeInformation", into: context) as! EmployeeInformation
        employeeInformation.taxId = "456"
        employeeInformation.birthday = birthday

        employee.employeeInformation = employeeInformation

        do {
            try context.save()
            return (employee, nil)
        } catch let createError {
            print("Error creating employee: \(createError)")
            return (nil, createError)
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
     - https://developer.apple.com/documentation/coredata/modeling_data/configuring_attributes?language=objc


### Checklist

- Relationship directions
- Cascading deletes (top down but not bottom up)

### Links that help

* [Live Cycle Managed Object](https://developer.apple.com/library/archive/documentation/Cocoa/Conceptual/CoreData/LifeofaManagedObject.html)
