//
//  Readme.swift
//  GitHub
//
//  Created by Anton Polyakov on 07/08/2019.
//  Copyright © 2019 ton252. All rights reserved.
//

import Foundation

/// Repository readme.
struct Readme {
    /// Readme file name.
    let name: String
    
    /// Readme encoded content.
    let content: String
    
    /// Readme decoded content.
    var decodedContent: String {
        return  content.base64Decoded() ?? ""
    }
}

extension Readme: Codable {
    //
}
