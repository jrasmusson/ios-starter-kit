//
//  ProtocolsAndParameterizationTests.swift
//  ProtocolsAndParameterizationTests
//
//  Created by Jonathan Rasmusson Work Pro on 2018-08-06.
//  Copyright © 2018 Rasmusson Software Consulting. All rights reserved.
//

import XCTest

@testable import ProtocolsAndParameterization

class ProtocolsAndParameterizationTests: XCTestCase {
    
    func testDocuementOpenerCanOpen() {
        
        // Given
        let urlOpener = MockURLOpener()
        urlOpener.canOpen = true
        let documentOpener = DocumentOpener(urlOpener: urlOpener as! URLOpening)
        
        // When
        documentOpener.open(Document(identifier: "TheID"), mode: .edit)
        
        // Then
        XCTAssertEqual(urlOpener.openedURL, URL(string: "myappscheme://open?id=TheID&mode=edit)"))
    }
    
}
