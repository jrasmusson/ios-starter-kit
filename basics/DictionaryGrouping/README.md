# Dictionary Grouping

Here is an example of how a `Dict` can be used to group data by values:

## Landmarks

```swift
struct Landmark: Hashable, Codable, Identifiable {
    var category: Category
    enum Category: String, CaseIterable, Codable {
        case lakes = "Lakes"
        case rivers = "Rivers"
        case mountains = "Mountains"
    }
}

var categories: [String: [Landmark]] {
    Dictionary(
        grouping: landmarks,
        by: { $0.category.rawValue }
    )
}
```

## Bankey

```swift
import UIKit

extension Date {
    static var bankeyDateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.timeZone = TimeZone(abbreviation: "MDT")
        return formatter
    }

    var monthDayYearString: String {
        let dateFormatter = Date.bankeyDateFormatter
        dateFormatter.dateFormat = "MMM d, yyyy"
        return dateFormatter.string(from: self)
    }

    func cutTimestamp() -> Date {
        let dateFormatter = Date.bankeyDateFormatter
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let str = dateFormatter.string(from: self)
        let date = dateFormatter.date(from: str)
        return date!
    }
}

func makeDate(day: Int, month: Int, year: Int) -> Date {
    let userCalendar = Calendar.current

    var components = DateComponents()
    components.year = year
    components.month = month
    components.day = day

    return userCalendar.date(from: components)!
}

struct Transaction: Hashable, Comparable {
    let date: Date
    let name: String

    static func < (lhs: Transaction, rhs: Transaction) -> Bool {
        if lhs.date == rhs.date {
            return lhs.name < rhs.name
        }
        return lhs.date < rhs.date
    }
}

let jan1 = makeDate(day: 1, month: 1, year: 2000)
let feb1 = makeDate(day: 1, month: 2, year: 2000)
let feb11 = makeDate(day: 1, month: 2, year: 2000)
let mar1 = makeDate(day: 1, month: 3, year: 2000)
let mar11 = makeDate(day: 1, month: 3, year: 2000)
let mar111 = makeDate(day: 1, month: 3, year: 2000)

let tx1 = Transaction(date: jan1, name: "name")
let tx21 = Transaction(date: feb1, name: "name")
let tx22 = Transaction(date: feb11, name: "name")
let tx31 = Transaction(date: mar1, name: "name")
let tx32 = Transaction(date: mar11, name: "name")
let tx33 = Transaction(date: mar111, name: "name")

let trans = [tx1, tx21, tx22, tx31, tx32, tx33]

let grouped: [Date: [Transaction]] = Dictionary(grouping: trans, by: { $0.date.cutTimestamp() })

// Dict are handy for grouping things - in this case by Date
//
// [Date: [Transactions]
// [Jan 1, 2000: [tx1]]
// [Feb 1, 2000: [tx2, tx22]]
// [Mar 1, 2000: [tx3, tx33, tx333]]

grouped.keys
grouped[jan1.cutTimestamp()]
grouped[feb1.cutTimestamp()]
grouped[mar1.cutTimestamp()]

// But unfortunately we can't work with Dict - we need an array of sections:
//
// let sections = [
//                  Section(title: "Jan 1, 2000", transactions: [smallest -> largest]
//                  Section(title: "Feb 1, 2000", transactions: [smallest -> largest]
//                  Section(title: "Mar 1, 2000", transactions: [smallest -> largest]
//                 ]

// So we create a struct

struct Section: Comparable {
    let date: Date
    var title: String {
        return date.monthDayYearString
    }
    var transactions: [Transaction]

    static func < (lhs: Section, rhs: Section) -> Bool {
        return lhs.date < rhs.date
    }
}

// And then we map the Dict into an Array of Sections, sorting the transactions as we go

var sections: [Section] = grouped.keys.map { key -> Section in
    let unsortedTransactions: [Transaction] = grouped[key] ?? []
    return Section(date: key, transactions: unsortedTransactions.sorted().reversed())
}

// Then we sort the sections by reverse date as well
sections.sorted().reversed()
```