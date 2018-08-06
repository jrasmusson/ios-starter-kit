//
//  DocumentOpener.swift
//  ProtocolsAndParameterization
//
//  Created by Jonathan Rasmusson Work Pro on 2018-08-06.
//  Copyright © 2018 Rasmusson Software Consulting. All rights reserved.
//

import Foundation
import UIKit

protocol URLOpening {
    func canOpenURL(_ url: URL) -> Bool
    func open(_ url: URL, options: [String: Any], completionHandler: ((Bool) -> Void)?)
}

extension UIApplication: URLOpening {
    // Nothing needed here!
}

class DocumentOpener {
    
    enum OpenMode: String {
        case view
        case edit
    }
    
    let urlOpener: URLOpening
    
    init(urlOpener: URLOpening = UIApplication.shared) {
        self.urlOpener = urlOpener
    }
    
    func open(_ document: Document, mode: OpenMode) {
        let modeString = mode.rawValue
        let url = URL(string: "myappscheme://open?id=\(document.identifier)&mode==\(modeString)")!
        
        if urlOpener.canOpenURL(url) {
            urlOpener.open(url, options: [:], completionHandler: nil)
        } else {
            // handleURLError()
        }
    }
}

class Document {
    var identifier: String!
    
    init(identifier: String) {
        self.identifier = identifier
    }
}

