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
