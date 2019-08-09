//
//  RepositorySearchResponse.swift
//  GitHub
//
//  Created by Anton Polyakov on 07/08/2019.
//  Copyright © 2019 ton252. All rights reserved.
//

import Foundation

/// Repository search response.
struct RepositorySearchResponse {
    let items: [Repository]
}

extension RepositorySearchResponse: Codable {
    //
}
