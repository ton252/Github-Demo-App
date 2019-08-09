//
//  RepositoryViewModel.swift
//  GitHub
//
//  Created by Anton Polyakov on 07/08/2019.
//  Copyright © 2019 ton252. All rights reserved.
//

import Foundation

struct RepositoryViewModel: ViewModel {
    let name: String
    let imageURL: URL?
    let description: String
    let owner: String
    let searchText: String
    
    init(model: Repository, searchText: String = "") {
        self.name = model.name
        self.description = model.description ?? "No description"
        self.imageURL = model.owner.avatarUrlValue
        self.owner = model.owner.login
        self.searchText = searchText
    }
}
