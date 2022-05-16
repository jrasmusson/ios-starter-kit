# How to load JSON in a unit test

Add json file to your test target.

Set it's target membership.

Then load

```swift
func testCanParseWeatherViaJSONFile() throws {

    guard let pathString = Bundle(for: type(of: self)).path(forResource: "weather", ofType: "json") else {
        fatalError("json not found")
    }

    guard let json = try? String(contentsOfFile: pathString, encoding: .utf8) else {
        fatalError("Unable to convert json to String")
    }

    let jsonData = json.data(using: .utf8)!
    let weatherData = try! JSONDecoder().decode(WeatherData.self, from: jsonData)
    
    XCTAssertEqual(10.58, weatherData.main.temp)
    XCTAssertEqual("Calgary", weatherData.name)
}
```

### Links that help
- [StackOverflow](https://stackoverflow.com/questions/16571051/how-to-read-in-a-local-json-file-for-testing)

## How to load JSON from file

**ModelData**

```swift
import Foundation

func load<T: Decodable>(_ filename: String) -> T {
    let data: Data

    guard let file = Bundle.main.url(forResource: filename, withExtension: nil)
    else {
        fatalError("Couldn't find \(filename) in main bundle.")
    }

    do {
        data = try Data(contentsOf: file)
    } catch {
        fatalError("Couldn't load \(filename) from main bundle:\n\(error)")
    }

    do {
        let decoder = JSONDecoder()
        return try decoder.decode(T.self, from: data)
    } catch {
        fatalError("Couldn't parse \(filename) as \(T.self):\n\(error)")
    }
}
```

- (Link)[https://developer.apple.com/tutorials/swiftui/building-lists-and-navigation]
