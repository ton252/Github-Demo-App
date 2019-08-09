//
//  SummaryViewModel.swift
//  GitHub
//
//  Created by Anton Polyakov on 08/08/2019.
//  Copyright © 2019 ton252. All rights reserved.
//

import Foundation

struct SummaryViewModel: ViewModel {
    var name: String = ""
    var owner: String = ""
    var description: String = ""
    var readme: String = ""
}

extension SummaryViewModel {
    
    init(viewModel: RepositoryViewModel) {
        self.name = viewModel.name
        self.owner = viewModel.owner
        self.description = viewModel.description
    }
    
}
