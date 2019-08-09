//
//  RepositoryZeroViewModel.swift
//  GitHub
//
//  Created by Anton Polyakov on 07/08/2019.
//  Copyright © 2019 ton252. All rights reserved.
//

import Foundation

struct ReposiztoryZeroViewModel {
    let title: String
    let image: String
    let suplimentary: String?
}

extension ReposiztoryZeroViewModel {
    
    static var empty: ReposiztoryZeroViewModel {
        return ReposiztoryZeroViewModel(
            title: Text.Zero.Error.notFound,
            image: "notFound",
            suplimentary: nil)
    }
    
    static var unknown: ReposiztoryZeroViewModel {
        return ReposiztoryZeroViewModel(
            title: Text.Zero.Error.unknown,
            image: "error",
            suplimentary: Text.Zero.Info.retry)
    }
    
    static var startSearch: ReposiztoryZeroViewModel {
        return ReposiztoryZeroViewModel(
            title: Text.Zero.Info.search,
            image: "search",
            suplimentary: nil)
    }
    
}

