//
//  SummaryErrorViewModel.swift
//  GitHub
//
//  Created by Anton Polyakov on 09.08.2019.
//  Copyright © 2019 ton252. All rights reserved.
//

import Foundation

struct SummaryErrorViewModel: ViewModel {
    let title: String
    let description: String
    let image: String
}

extension SummaryErrorViewModel {
    
    static var summaryError: SummaryErrorViewModel {
        return SummaryErrorViewModel(
            title: Text.Summary.Error.title,
            description: Text.Summary.Error.description,
            image: "reload")
    }

}
