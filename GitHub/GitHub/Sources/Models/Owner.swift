//
//  Owner.swift
//  GitHub
//
//  Created by Anton Polyakov on 07/08/2019.
//  Copyright © 2019 ton252. All rights reserved.
//

import Foundation


/// The repository owner.
struct Owner {
    /// Owner unique identifier.
    let id: Int
    
    /// Owner login.
    let login: String
    
    /// Owner avatar url string.
    let avatarUrl: String?
    
    /// Owner avater url.
    var avatarUrlValue: URL? {
        guard let url = self.avatarUrl else { return nil }
        return URL(string: url)
    }
}

extension Owner: Codable {
    
}
