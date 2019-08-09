//
//  RepositorySearch.swift
//  GitHub
//
//  Created by Anton Polyakov on 07/08/2019.
//  Copyright © 2019 ton252. All rights reserved.
//

import Foundation

/// Repository search parameters
///
enum RepositorySearch {
    
    /// Sort parameters
    ///
    /// - stars: Sort by stars
    /// - forks: Sort by forks
    /// - bestMatch: Sort by best matches
    enum Sort: String {
        case stars = "stars"
        case forks = "forks"
        case bestMatch = "best-match"
    }
    
    /// Order parameters
    ///
    /// - ascending: Ascending sort
    /// - descending: Descending sort
    enum Order: String {
        case ascending = "asc"
        case descending = "desc"
    }
    
}
