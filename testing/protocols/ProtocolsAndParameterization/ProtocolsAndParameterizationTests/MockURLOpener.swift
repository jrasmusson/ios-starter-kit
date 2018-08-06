//
//  MockURLOpener.swift
//  ProtocolsAndParameterizationTests
//
//  Created by Jonathan Rasmusson Work Pro on 2018-08-06.
//  Copyright © 2018 Rasmusson Software Consulting. All rights reserved.
//

import Foundation

class MockURLOpener: URLOpening {
    var canOpen = false
    var openedURL: URL?
    
    func canOpenURL(_ url: URL) -> Bool {
        return canOpen
    }
    
    func open(_ url: URL, options: [String: Any], completionHandler: ((Bool) -> Void)?) {
        openedURL = url
    }
}



