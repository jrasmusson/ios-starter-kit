# How to test ViewControllers


```swift
//
//  Tests.swift
//  Tests
//
//  Created by Jonathan Rasmusson on 2018-11-23.
//  Copyright © 2018 Jonathan Rasmusson. All rights reserved.
//

import XCTest
import UnitTests

class Tests: XCTestCase {

    var parser: JSONParser!

    override func setUp() {
        parser = JSONParser()
    }

    func testParsingResponse() throws {
        let jsonData = "[{\"name\":\"My Location\"}]".data(using: .utf8)!
        let response = try parser.parseResponse(data: jsonData)

        let expected = PointOfInterest(name: "My Location")
        let actual = response[0]

        XCTAssertEqual(expected, actual)
    }

}
```

```swift
//
//  JSONParser.swift
//  UnitTests
//
//  Created by Jonathan Rasmusson on 2018-11-23.
//  Copyright © 2018 Jonathan Rasmusson. All rights reserved.
//

import Foundation

public struct PointOfInterest: Codable {
    public let name: String

    public init(name: String) {
        self.name = name
    }

}

extension PointOfInterest {

    enum MyStructKeys: String, CodingKey {
        case name = "name"
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: MyStructKeys.self)
        let name: String = try container.decode(String.self, forKey: .name)
        
        self.init(name: name)
    }
}

extension PointOfInterest: Comparable {

    public static func == (lhs: PointOfInterest, rhs: PointOfInterest) -> Bool {
        return lhs.name == rhs.name
    }

    public static func < (lhs: PointOfInterest, rhs: PointOfInterest) -> Bool {
        return lhs.name < rhs.name
    }
}

public struct JSONParser {

    public init() {}
    
    public func parseResponse(data: Data) throws -> [PointOfInterest] {
        return try JSONDecoder().decode([PointOfInterest].self, from: data)
    }
}
```

### Links that help

* [Testing Tips & Tricks - WWDC 2018](https://developer.apple.com/videos/play/wwdc2018/417/?time=761)

