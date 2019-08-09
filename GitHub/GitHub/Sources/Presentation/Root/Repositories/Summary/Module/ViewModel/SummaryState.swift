//
//  SummaryState.swift
//  GitHub
//
//  Created by Anton Polyakov on 09.08.2019.
//  Copyright © 2019 ton252. All rights reserved.
//

import Foundation

enum SummaryState {
    case rich(vm: ViewModel)
    case loading(vm: SummaryShimmeringViewModel)
    case error(vm: SummaryErrorViewModel)
    
    var viewModel: ViewModel {
        switch self {
        case .rich(let vm): return vm
        case .loading(let vm): return vm
        case .error(let vm): return vm
        }
    }
}
