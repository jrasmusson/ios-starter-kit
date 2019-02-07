# How to test errors

Say we want to test that one of our classes throws a specific error.

```swift
class Translator {
    func translate(_ text: String) throws -> String {
        throw Error.emptyText
    }
}

extension Translator {
    enum Error: Swift.Error, Equatable {
        case emptyText
        case tooManyWords(count: Int)
        case unknownWords([String])
    }
}
```

We can test that like this

```swift
import XCTest
@testable import Foo

class TranslatorTests: XCTestCase {

    func testEmptyTextError() {
        let translator = Translator()
        var thrownError: Error?

        // Capture the thrown error using a closure
        XCTAssertThrowsError(try translator.translate("")) {
            thrownError = $0
        }

        // First we’ll verify that the error is of the right
        // type, to make debugging easier in case of failures.
        XCTAssertTrue(
            thrownError is Translator.Error,
            "Unexpected error type: \(type(of: thrownError))"
        )

        // Verify that our error is equal to what we expect
        XCTAssertEqual(thrownError as? Translator.Error, .emptyText)
    }

    func testEmptyTextCausingError() {
        let translator = Translator()

        assert(try translator.translate(""), throws: Translator.Error.emptyText)
    }
}

extension XCTestCase {
    func assert<T, E: Error & Equatable>(
        _ expression: @autoclosure () throws -> T, // 1st argument - a closure that throws and returns a genertic type T (or for us String)
        throws error: E,                           // 2nd argument - an error with variable name E (throws is a paremeter descriptor)
        in file: StaticString = #file,             // Optional - filename with default value #file
        line: UInt = #line                         // Optional - line number with default value #line
        ) {
        var thrownError: Error?                    // optional variable for error

        XCTAssertThrowsError(try expression(),
                             file: file, line: line) {
                                thrownError = $0  // which we set down here
        }

        XCTAssertTrue(                            // now with thrownError, we can make some assertions
            thrownError is E,                     // i.e. that error is of a particular type
            "Unexpected error type: \(type(of: thrownError))",
            file: file, line: line
        )

        XCTAssertEqual(
            thrownError as? E, error,            // and is a specific error
            file: file, line: line
        )
    }
}
```

### Links that help

* [Swift by Sundel](https://www.swiftbysundell.com/posts/testing-error-code-paths-in-swift)

