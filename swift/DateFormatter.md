# Dates

## Formatter

```swift
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
```

```swift
var dateFormatted: String {
    return date.monthDayYearString
}
```

## Make date

```swift
func makeDate(day: Int, month: Int, year: Int) -> Date {
   let userCalendar = Calendar.current

   var components = DateComponents()
   components.year = year
   components.month = month
   components.day = day

   return userCalendar.date(from: components)!
}
```

## Formatters
```swift
import UIKit

var str = "Hello, playground"

/*
 Dates
 */

let fiveMinutesAgo = Date(timeIntervalSinceNow: -5 * 60)
let fiveMinutesFromNow = Date(timeIntervalSinceNow: 5 * 60)

/*
 Calendar and DatComponents
 */

let userCalendar = Calendar.current

var firstCellCallDateComponents = DateComponents()
 
firstCellCallDateComponents.year = 1973
firstCellCallDateComponents.month = 4
firstCellCallDateComponents.day = 3
firstCellCallDateComponents.day = 9
firstCellCallDateComponents.hour = 15
firstCellCallDateComponents.minute = 45
firstCellCallDateComponents.timeZone = TimeZone(abbreviation: "EST")
 
let firstCellCallDate = userCalendar.date(from: firstCellCallDateComponents)!
print("Martin Cooper made the first cellular call on \(firstCellCallDate.description(with: Locale(identifier: "en-US"))).")

/*
 Ordinals
 */

let donutDay2020Components = DateComponents(
  year: 2020,         // We want a date in 2020,
  month: 6,           // in June.
  weekday: 6,         // We want a Friday;
  weekdayOrdinal: 1   // the first one.
)
let donutDay2020 = userCalendar.date(from: donutDay2020Components)!

let day234DateComponents = DateComponents(
  year: 2020,         // We want a date in 2020:
  day: 234            // the 234th day.
)
let day234Date = userCalendar.date(from: day234DateComponents)!

let hour10kDateComponents = DateComponents(
  year: 2020,         // We want a date in 2020:
  hour: 10000         // the 10000th hour.
)
 
let hour10kDate = userCalendar.date(from: hour10kDateComponents)!

// We want to extract the year, month, and day from date
let componentsFromDate = userCalendar.dateComponents([.year, .month, .day], from: hour10kDate)
print("Year: \(componentsFromDate.year!)")
print("Month: \(componentsFromDate.month!)")
print("Day: \(componentsFromDate.day!)")

/*
 DateFormatter
 */
print()

let swiftDebutDateComponents = DateComponents(
  year: 2014,
  month: 6,
  day: 2
)
let swiftDebutDate = userCalendar.date(from: swiftDebutDateComponents)!


let myFormatter = DateFormatter()
myFormatter.dateStyle = .short
print("“short” style: \(myFormatter.string(from: swiftDebutDate)).")

myFormatter.dateStyle = .medium
print("“medium” style: \(myFormatter.string(from: swiftDebutDate))")

myFormatter.dateStyle = .long
print("“long” style: \(myFormatter.string(from: swiftDebutDate))")

myFormatter.dateStyle = .full
print("“full” style: \(myFormatter.string(from: swiftDebutDate))")

// SwiftUI was introduced at WWDC 2019 on
// June 3, 2019 at 12:08 p.m. Pacific Daylight Time.
print()

let swiftUIDebutDateComponents = DateComponents(
  timeZone: TimeZone(abbreviation: "PDT"),
  year: 2019,
  month: 6,
  day: 3,
  hour: 12,
  minute: 8
)
let swiftUIDebutDate = userCalendar.date(from: swiftUIDebutDateComponents)!

myFormatter.dateStyle = .short
myFormatter.timeStyle = .short
print("“short” style: \(myFormatter.string(from: swiftUIDebutDate)).")

myFormatter.dateStyle = .medium
myFormatter.timeStyle = .medium
print("“medium” style: \(myFormatter.string(from: swiftUIDebutDate)).")

myFormatter.dateStyle = .long
myFormatter.timeStyle = .long
print("“long” style: \(myFormatter.string(from: swiftUIDebutDate)).")

myFormatter.dateStyle = .full
myFormatter.timeStyle = .full
print("“full” style: \(myFormatter.string(from: swiftUIDebutDate)).")

/*
 Other languages
 */

// We want to see as much of these languages as possible,
// so let’s set both dateStyle and timeStyle to .full.
print()

myFormatter.dateStyle = .full
myFormatter.timeStyle = .full

myFormatter.locale = Locale(identifier: "fr")
print("International French: \(myFormatter.string(from: swiftUIDebutDate)).")

myFormatter.locale = Locale(identifier: "fr-CA")
print("Canadian French: \(myFormatter.string(from: swiftUIDebutDate)).")

myFormatter.locale = Locale(identifier: "hr")
print("Croatian: \(myFormatter.string(from: swiftUIDebutDate)).")

myFormatter.locale = Locale(identifier: "ko_KR")
print("Korean: \(myFormatter.string(from: swiftUIDebutDate)).")

/*
 Custom date formats
 */

// DateFormatter's format string uses the date format specifiers
// spelled out in Unicode Technical Standard #35 (located at
// http://www.unicode.org/reports/tr35/tr35-25.html#Date_Format_Patterns)
print()

myFormatter.dateFormat = "y-MM-dd"
print("Swift’s debut date and time, y-MM-dd format: \(myFormatter.string(from: swiftUIDebutDate)).")

myFormatter.dateFormat = "'Year: 'y' Month: 'M' Day: 'd"
print("Swift’s debut date and time, in labeled y M d format: \(myFormatter.string(from: swiftUIDebutDate)).")

myFormatter.dateFormat = "MM/dd/yy"
print("Swift’s debut date and time, MM/dd/yy format: \(myFormatter.string(from: swiftUIDebutDate)).")

myFormatter.dateFormat = "MMM dd, yyyy"
print("Swift’s debut date and time, MMM dd, yyyy format: \(myFormatter.string(from: swiftUIDebutDate)).")

myFormatter.dateFormat = "E MMM dd, yyyy"
print("Swift’s debut date and time, E MMM dd, yyyy format: \(myFormatter.string(from: swiftUIDebutDate)).")

myFormatter.dateFormat = "EEEE, MMMM dd, yyyy' at 'h:mm a"
print("Swift’s debut date and time, EEEE, MMMM dd, yyyy' at 'h:mm a. format: \(myFormatter.string(from: swiftUIDebutDate)).")

myFormatter.dateFormat = "EEEE, MMMM dd, yyyy' at 'h:mm a zzzz"
print("Swift’s debut date and time, EEEE, MMMM dd, yyyy' at 'h:mm a zzzz. format: \(myFormatter.string(from: swiftUIDebutDate)).")

/*
 String into a Date
 */
print()

// Let’s define the format for date strings we want to parse:
myFormatter.dateFormat = "yyyy/MM/dd hh:mm Z"

// Here's a date in the specified format.
// DateFormatter’s date(from:) method will be able to parse it.
let newDate1 = myFormatter.date(from: "2019/06/03 12:08 -0700")
print("newDate1’s value is: \(newDate1?.description ?? "nil").")

/*
 Date arithmetic
 */
print()

// Let's create a Date for the start of the Stevenote
// where the iPhone was introduced (January 9, 2007, 10:00:00 Pacific time)
// using DateComponents.
let iPhoneStevenoteDateComponents = DateComponents(
  timeZone: TimeZone(abbreviation: "PST"),
  year: 2007,
  month: 1,
  day: 9,
  hour: 10
)
let iPhoneStevenoteDate = userCalendar.date(from: iPhoneStevenoteDateComponents)!

// Let's create a Date for the start of the Stevenote
// where the iPad was introduced (January 27, 2010, 10:00:00 Pacific time)
// using DateFormatter.
var dateMakerFormatter = DateFormatter()
dateMakerFormatter.calendar = userCalendar
dateMakerFormatter.dateFormat = "MMM d, yyyy, hh:mm a zz"
let iPadStevenoteDate = dateMakerFormatter.date(from: "Jan 27, 2010, 10:00 AM PST")!

// How far apart at this date in days?

let daysBetweenStevenotes = userCalendar.dateComponents([.day],
                                                        from: iPhoneStevenoteDate,
                                                        to: iPadStevenoteDate)
print("There were \(daysBetweenStevenotes.day!) days between the iPhone Stevenote of 2007 and the iPad Stevenote of 2010.")

// In weeks?

let weeksBetweenStevenotes = userCalendar.dateComponents([.weekOfYear],
                                                         from: iPhoneStevenoteDate,
                                                         to: iPadStevenoteDate)
print("There were \(weeksBetweenStevenotes.weekOfYear!) weeks between the iPhone Stevenote of 2007 and the iPad Stevenote of 2010.")

// In years, months, days

let yearsMonthsDaysHoursMinutesBetweenStevenotes = userCalendar.dateComponents(
  [.year, .month, .day, .hour, .minute],
  from: iPhoneStevenoteDate,
  to: iPadStevenoteDate
)
let years = yearsMonthsDaysHoursMinutesBetweenStevenotes.year!
let months = yearsMonthsDaysHoursMinutesBetweenStevenotes.month!
let days = yearsMonthsDaysHoursMinutesBetweenStevenotes.day!
let hours = yearsMonthsDaysHoursMinutesBetweenStevenotes.hour!
let minutes = yearsMonthsDaysHoursMinutesBetweenStevenotes.minute!
print("There were \(years) years, \(months) months, \(days) days, \(hours) hours, and \(minutes) minutes between the the iPhone Stevenote of 2007 and the iPad Stevenote of 2010.")

/*
 Addition - what is last day of the 90 days warranty?
 */
print()

// What's the last day of a 90-day warranty that starts today?
let lastDay = userCalendar.date(byAdding: .day, value: 90, to: Date())!
print("90 days from now is: \(lastDay.description(with: Locale(identifier: "en_US")))")

// What was the date 5 weeks ago?
let fiveWeeksAgo = userCalendar.date(byAdding: .weekOfYear, value: -5, to: Date())!
print("5 weeks ago was: \(fiveWeeksAgo.description(with: Locale(identifier: "en_US")))")

// What time will it be 4 hours and 30 minutes from now?
// First, we need to define a DateComponents struct representing
// a time interval of 4 hours and 30 minutes
var fourHoursThirtyMinutes = DateComponents()
fourHoursThirtyMinutes.hour = 4
fourHoursThirtyMinutes.minute = 30

// Now add the interval to the Date
let fourHoursThirtyMinutesFromNow = userCalendar.date(
  byAdding: fourHoursThirtyMinutes,
  to: Date()
)!
print("4 hours and 30 minutes from now will be: \(fourHoursThirtyMinutesFromNow.description(with: Locale(identifier: "en_US")))")

// What time was it 4 hours and 30 minutes ago?
var minusFourHoursThirtyMinutes = DateComponents()
minusFourHoursThirtyMinutes.hour = -4
minusFourHoursThirtyMinutes.minute = -30
let fourHoursThirtyMinutesAgo = userCalendar.date(
  byAdding: fourHoursThirtyMinutes,
  to: Date()
)!
print("4 hours and 30 minutes ago was: \(fourHoursThirtyMinutesAgo.description(with: Locale(identifier: "en_US")))")

/*
 More human friendly
 */
print()

// Let's define some Dates relative to the SwiftUI announcement
// (June 3, 2019, 12:08 p.m. PDT)
let swiftUIAnnouncementDateComponents = DateComponents(
  timeZone: TimeZone(abbreviation: "PDT"),
  year: 2019,
  month: 6,
  day: 3,
  hour: 12,
  minute: 8
)
let swiftUIAnnouncement = userCalendar.date(from: swiftUIAnnouncementDateComponents)!

let swiftUIAnnouncementPlusOneSecond = userCalendar.date(
  byAdding: .second,
  value: 1,
  to: swiftUIAnnouncement
)!
let swiftUIAnnouncementPlusFiveMinutes = userCalendar.date(
  byAdding: .minute,
  value: 5,
  to: swiftUIAnnouncement
)!
let swiftUIAnnouncementPlusThreeHours = userCalendar.date(
  byAdding: .hour,
  value: 3,
  to: swiftUIAnnouncement
)!

// This returns false, because when measuring time at the granularity of a SECOND,
// swiftUIAnnouncement happens BEFORE swiftUIAnnouncementPlusOneSecond.
let test1 = userCalendar.compare(swiftUIAnnouncement,
                                 to: swiftUIAnnouncementPlusOneSecond,
                                 toGranularity: .second)
  == .orderedSame
print("test1: \(test1)")

// This returns true, because when measuring time at the granularity of a SECOND,
// swiftUIAnnouncement happens BEFORE swiftUIAnnouncementPlusOneSecond.
let test2 = userCalendar.compare(swiftUIAnnouncement,
                                 to: swiftUIAnnouncementPlusOneSecond,
                                 toGranularity: .second)
  == .orderedAscending
print("test2: \(test2)")

// This returns true, because when measuring time at the granularity of a MINUTE,
// swiftUIAnnouncement happens AT THE SAME TIME AS swiftUIAnnouncementPlusOneSecond.
let test3 = userCalendar.compare(swiftUIAnnouncement,
                                 to: swiftUIAnnouncementPlusOneSecond,
                                 toGranularity: .minute)
  == .orderedSame
print("test3: \(test3)")

// This returns true, because when measuring time at the granularity of an HOUR,
// swiftUIAnnouncement happens AT THE SAME TIME AS swiftUIAnnouncementPlusFiveMinutes.
let test4 = userCalendar.compare(swiftUIAnnouncement,
                                 to: swiftUIAnnouncementPlusFiveMinutes,
                                 toGranularity: .hour)
  == .orderedSame
print("test4: \(test4)")

// This returns true, because when measuring time at the granularity of a MINUTE,
// swiftUIAnnouncementPlusFiveMinutes happens AFTER swiftUIAnnouncement.
let test5 = userCalendar.compare(swiftUIAnnouncementPlusFiveMinutes,
                                 to: swiftUIAnnouncement,
                                 toGranularity: .minute)
  == .orderedDescending
print("test5: \(test5)")

// This returns true, because when measuring time at the granularity of a DAY,
// swiftUIAnnouncement happens AT THE SAME TIME AS swiftUIAnnouncementPlusThreeHours.
let test6 = userCalendar.compare(swiftUIAnnouncement,
                                 to: swiftUIAnnouncementPlusThreeHours,
                                 toGranularity: .day)
  == .orderedSame
print("test6: \(test6)")

/*
 Syntactic magic - overriding + and -
 */

var timeInterval = DateComponents(
  month: 2,
  day: 3,
  hour: 4,
  minute: 5,
  second: 6
)
let futureDate = Calendar.current.date(byAdding: timeInterval, to: Date())!
print("2 months, 3 days, 4 hours, 5 minutes, and 6 seconds from now is \(futureDate.description(with: Locale(identifier: "en_US"))).")


// Overloading + and - so that we can add and subtract DateComponents
// ==================================================================

func +(_ lhs: DateComponents, _ rhs: DateComponents) -> DateComponents {
  return combineComponents(lhs, rhs)
}

func -(_ lhs: DateComponents, _ rhs: DateComponents) -> DateComponents {
  return combineComponents(lhs, rhs, multiplier: -1)
}

func combineComponents(_ lhs: DateComponents,
                       _ rhs: DateComponents,
                       multiplier: Int = 1)
  -> DateComponents {
    var result = DateComponents()
    result.nanosecond = (lhs.nanosecond ?? 0) + (rhs.nanosecond ?? 0) * multiplier
    result.second     = (lhs.second     ?? 0) + (rhs.second     ?? 0) * multiplier
    result.minute     = (lhs.minute     ?? 0) + (rhs.minute     ?? 0) * multiplier
    result.hour       = (lhs.hour       ?? 0) + (rhs.hour       ?? 0) * multiplier
    result.day        = (lhs.day        ?? 0) + (rhs.day        ?? 0) * multiplier
    result.weekOfYear = (lhs.weekOfYear ?? 0) + (rhs.weekOfYear ?? 0) * multiplier
    result.month      = (lhs.month      ?? 0) + (rhs.month      ?? 0) * multiplier
    result.year       = (lhs.year       ?? 0) + (rhs.year       ?? 0) * multiplier
    return result
}


// Let's define a couple of durations of time
// ------------------------------------------

var oneDayFiveHoursTenMinutes = DateComponents(
  day: 1,
  hour: 5,
  minute: 10
)
var threeDaysTenHoursThirtyMinutes = DateComponents(
  day: 3,
  hour: 10,
  minute: 30
)


// Now let's add and subtract them
// -------------------------------

let additionResult = oneDayFiveHoursTenMinutes + threeDaysTenHoursThirtyMinutes
print("1 day, 5 hours, and 10 minutes + 3 days, 10 hours, and 30 minutes equals:")
print("\(additionResult.day!) days, \(additionResult.hour!) hours, and \(additionResult.minute!) minutes.")

let subtractionResult = threeDaysTenHoursThirtyMinutes - oneDayFiveHoursTenMinutes
print("1 day, 5 hours, and 10 minutes - 3 days, 10 hours, and 30 minutes equals:")
print("\(subtractionResult.day!) days, \(subtractionResult.hour!) hours, and \(subtractionResult.minute!) minutes.")


// Overloading - so that we can negate DateComponents
// --------------------------------------------------

// We'll need to overload unary - so we can negate components
prefix func -(components: DateComponents) -> DateComponents {
  var result = DateComponents()
  if components.nanosecond != nil { result.nanosecond = -components.nanosecond! }
  if components.second     != nil { result.second     = -components.second! }
  if components.minute     != nil { result.minute     = -components.minute! }
  if components.hour       != nil { result.hour       = -components.hour! }
  if components.day        != nil { result.day        = -components.day! }
  if components.weekOfYear != nil { result.weekOfYear = -components.weekOfYear! }
  if components.month      != nil { result.month      = -components.month! }
  if components.year       != nil { result.year       = -components.year! }
  return result
}


let negativeTime = -oneDayFiveHoursTenMinutes
print("Negating 1 day, 5 hours, and 10 minutes turns it into:")
print("\(negativeTime.day!) days, \(negativeTime.hour!) hours, and \(negativeTime.minute!) minutes.")


// Overloading + and - so that we can add Dates and DateComponents
// and subtract DateComponents from Dates

// Date + DateComponents
func +(_ lhs: Date, _ rhs: DateComponents) -> Date
{
  return Calendar.current.date(byAdding: rhs, to: lhs)!
}

// DateComponents + Dates
func +(_ lhs: DateComponents, _ rhs: Date) -> Date
{
  return rhs + lhs
}

// Date - DateComponents
func -(_ lhs: Date, _ rhs: DateComponents) -> Date
{
  return lhs + (-rhs)
}


// What time will it be 1 day, 5 hours, and 10 minutes from now?
// -------------------------------------------------------------

// Here's the standard way of finding out:
let futureDate0 = Calendar.current.date(
  byAdding: oneDayFiveHoursTenMinutes,
  to: Date()
)

// With our overloads and function definitions, we can now do it this way:
let futureDate1 = Date() + oneDayFiveHoursTenMinutes
print("Date() + oneDayFiveHoursTenMinutes = \(futureDate1.description(with: Locale(identifier: "en_US")))")

// This will work as well:
let futureDate2 = oneDayFiveHoursTenMinutes + Date()
print("oneDayFiveHoursTenMinutes + Date() = \(futureDate2.description(with: Locale(identifier: "en_US")))")


// What time was it 3 days, 10 hours, and 30 minutes ago?
// ------------------------------------------------------

// Doing it the standard way takes some work
var minus3Days5Hours30minutes = threeDaysTenHoursThirtyMinutes
minus3Days5Hours30minutes.day = -threeDaysTenHoursThirtyMinutes.day!
minus3Days5Hours30minutes.hour = -threeDaysTenHoursThirtyMinutes.hour!
minus3Days5Hours30minutes.minute = -threeDaysTenHoursThirtyMinutes.minute!
let pastDate0 = Calendar.current.date(byAdding: minus3Days5Hours30minutes, to: Date())

// With our overloads and function definitions, it's so much easier:
let pastDate1 = Date() - threeDaysTenHoursThirtyMinutes
print("Date() - threeDaysTenHoursThirtyMinutes = \(pastDate1.description(with: Locale(identifier: "en_US")))")


// Extending Date so that creating dates and debugging are simpler
// ===============================================================

extension Date {

  init(year: Int,
       month: Int,
       day: Int,
       hour: Int = 0,
       minute: Int = 0,
       second: Int = 0,
       timeZone: TimeZone = TimeZone(abbreviation: "UTC")!) {
    var components = DateComponents()
    components.year = year
    components.month = month
    components.day = day
    components.hour = hour
    components.minute = minute
    components.second = second
    components.timeZone = timeZone
    self = Calendar.current.date(from: components)!
  }

  init(dateString: String) {
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy-MM-dd HH:mm:ss zz"
    self = formatter.date(from: dateString)!
  }

  var desc: String {
    get {
      let PREFERRED_LOCALE = "en_US" // Use whatever locale you prefer!
      return self.description(with: Locale(identifier: PREFERRED_LOCALE))
    }
  }

}

// Overloading - so that we can use it to find the difference
// between two Dates
// ==========================================================

func -(_ lhs: Date, _ rhs: Date) -> DateComponents
{
  return Calendar.current.dateComponents(
    [.year, .month, .weekOfYear, .day, .hour, .minute, .second, .nanosecond],
    from: rhs,
    to: lhs)
}

// How long was it between the announcement of the original iPhone
// and its release in the stores?
let iPhoneReleaseDate = Date(year: 2007, month: 6, day: 27)

let iPhoneWait = iPhoneReleaseDate - iPhoneStevenoteDate
print("The first iPhone users had to wait this long: ")
print("\(iPhoneWait.year!) years, " +
  "\(iPhoneWait.month!) months, " +
  "\(iPhoneWait.weekOfYear!) weeks, " +
  "\(iPhoneWait.day!) days, " +
  "\(iPhoneWait.hour!) hours, and " +
  "\(iPhoneWait.minute!) minutes.")

// How long ago was the first moon landing, which took place
// on July 20, 1969, 20:18 UTC?
let timeSinceMoonLanding = Date() - Date(dateString: "1969-07-20 20:18:00 UTC")
print("It’s been this long since the first moon landing: ")
print("\(timeSinceMoonLanding.year!) years, " +
  "\(timeSinceMoonLanding.month!) months, " +
  "\(timeSinceMoonLanding.weekOfYear!) weeks, " +
  "\(timeSinceMoonLanding.day!) days, " +
  "\(timeSinceMoonLanding.hour!) hours, and " +
  "\(timeSinceMoonLanding.minute!) minutes.")


// Extending Int to add some syntactic magic to date components
// ============================================================

extension Int {

  var second: DateComponents {
    var components = DateComponents()
    components.second = self;
    return components
  }

  var seconds: DateComponents {
    return self.second
  }

  var minute: DateComponents {
    var components = DateComponents()
    components.minute = self;
    return components
  }

  var minutes: DateComponents {
    return self.minute
  }

  var hour: DateComponents {
    var components = DateComponents()
    components.hour = self;
    return components
  }

  var hours: DateComponents {
    return self.hour
  }

  var day: DateComponents {
    var components = DateComponents()
    components.day = self;
    return components
  }

  var days: DateComponents {
    return self.day
  }

  var week: DateComponents {
    var components = DateComponents()
    components.weekOfYear = self;
    return components
  }

  var weeks: DateComponents {
    return self.week
  }

  var month: DateComponents {
    var components = DateComponents()
    components.month = self;
    return components
  }

  var months: DateComponents {
    return self.month
  }

  var year: DateComponents {
    var components = DateComponents()
    components.year = self;
    return components
  }

  var years: DateComponents {
    return self.year
  }

}


// A quick test of some future dates
print("One hour from now is: \((Date() + 1.hour).desc)")
print("One day from now is: \((Date() + 1.day).desc)")
print("One week from now is: \((Date() + 1.week).desc)")
print("One month from now is: \((Date() + 1.month).desc)")
print("One year from now is: \((Date() + 1.year).desc)")

// What was the date 10 years, 9 months, 8 days, 7 hours, and 6 minutes ago?
let aLittleWhileBack = Date() - 10.years - 9.months - 8.days - 7.hours - 6.minutes
print("10 years, 9 months, 8 days, 7 hours, and 6 minutes ago, it was: \(aLittleWhileBack.desc)")


// Extending DateComponents to add even more syntactic magic: fromNow and ago
// ==========================================================================

extension DateComponents {

  var fromNow: Date {
    return Calendar.current.date(byAdding: self,
                                 to: Date())!
  }

  var ago: Date {
    return Calendar.current.date(byAdding: -self,
                                 to: Date())!
  }

}

// We’re now in Serious Syntax Magic Land!
// ---------------------------------------

print("2.weeks.fromNow: \(2.weeks.fromNow.desc)")
print("3.months.fromNow: \(3.months.fromNow.desc)")

let futureDate3 = (2.months + 3.days + 4.hours + 5.minutes + 6.seconds).fromNow
print("futureDate3: \(futureDate3.desc)")

let pastDate2 = (2.months + 3.days + 4.hours + 5.minutes + 6.seconds).ago
print("pastDate2: \(pastDate2.desc)")
```

### Links that help

- [DateFormatter](https://developer.apple.com/documentation/foundation/dateformatter)
- [Creating Dates](https://www.globalnerdy.com/2020/05/26/how-to-work-with-dates-and-times-in-swift-5-part-1-creating-and-deconstructing-dates-with-the-date-calendar-and-datecomponents-structs/)
