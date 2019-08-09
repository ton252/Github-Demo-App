//
//  Repository.swift
//  GitHub
//
//  Created by Anton Polyakov on 07/08/2019.
//  Copyright © 2019 ton252. All rights reserved.
//

import Foundation

/// Github repository
struct Repository {
    /// Repository name.
    let name: String
    
    /// Repository owner.
    let owner: Owner
    
    /// Short repository description.
    let description: String?
}

extension Repository: Codable {
    //
}
