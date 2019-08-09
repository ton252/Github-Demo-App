//
//  SummaryContentType.swift
//  GitHub
//
//  Created by Anton Polyakov on 09.08.2019.
//  Copyright © 2019 ton252. All rights reserved.
//

import Foundation

enum SummaryContentType {
    case description
    case languages
    case readme
    
    var name: String {
        switch self {
        case .description:
            return Text.Summary.Section.description
        case .languages:
            return Text.Summary.Section.languages
        case .readme:
            return Text.Summary.Section.readme
        }
    }
}

