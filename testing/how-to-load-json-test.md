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

**landmarkData.json**

```
[
    {
        "name": "Turtle Rock",
        "category": "Rivers",
        "city": "Twentynine Palms",
        "state": "California",
        "id": 1001,
        "isFeatured": true,
        "isFavorite": true,
        "park": "Joshua Tree National Park",
        "coordinates": {
            "longitude": -116.166868,
            "latitude": 34.011286
        },
]
```

**Landmark**

```swift
import Foundation
import SwiftUI
import MapKit

struct Landmark: Hashable, Codable {
    var id: Int
    var name: String
    var park: String
    var state: String
    var description: String

    private var imageName: String
    var image: Image {
        Image(imageName)
    }

    private var coordinates: Coordinates
    var locationCoordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(
            latitude: coordinates.latitude,
            longitude: coordinates.longitude)
    }

    struct Coordinates: Hashable, Codable {
        var latitude: Double
        var longitude: Double
    }
}
```

**ModelData**

```swift
import Foundation

var landmarks: [Landmark] = load("landmarkData.json")

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

- [Link](https://developer.apple.com/tutorials/swiftui/building-lists-and-navigation)
