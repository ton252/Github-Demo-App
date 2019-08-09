//
//  Language.swift
//  GitHub
//
//  Created by Anton Polyakov on 07/08/2019.
//  Copyright © 2019 ton252. All rights reserved.
//

import Foundation

/// Repository language
struct Language {
    /// Language name.
    let name: String
    
    /// Langunage number of bytes in repository.
    let bytes: Int
}

extension Language {
    
    static func parse(dictionary: [String: Int]) -> [Language] {
        return dictionary.keys.map { Language(name: $0, bytes: dictionary[$0]!) }
    }
    
}
