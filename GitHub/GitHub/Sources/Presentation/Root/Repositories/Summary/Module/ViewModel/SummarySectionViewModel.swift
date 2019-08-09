//
//  SectionViewModel.swift
//  GitHub
//
//  Created by Anton Polyakov on 08/08/2019.
//  Copyright © 2019 ton252. All rights reserved.
//

import Foundation

final class SummarySectionViewModel {
    var state: SummaryState
    var type: SummaryContentType
    
    var title: String {
        return self.type.name
    }
    
    var viewModels: [ViewModel] {
        return [self.state.viewModel]
    }
    
    init(state: SummaryState, type: SummaryContentType) {
        self.state = state
        self.type = type
    }
}
