//
//  RepositoriesRepositoriesInteractor.swift
//  GitHub
//
//  Created by Anton Polyakov on 07/08/2019.
//  Copyright © 2019 ton252. All rights reserved.
//

import Foundation

class RepositoriesInteractor {

    weak var output: RepositoriesInteractorOutput!
    
    private let service: GithubServiceProtocol
    private var previousRequest: Cancelable?
    
    init(service: GithubServiceProtocol) {
        self.service = service
    }

}

// MARK: - RepositoriesInteractorInput

extension RepositoriesInteractor: RepositoriesInteractorInput {
    
    func search(text: String) {
        self.previousRequest?.cancel()
        
        guard !text.isEmpty else {
            self.output.data(text: text, respositories: .success([]))
            return
        }
        
        self.previousRequest = self.service.searchRepositories(q: text, sort: .bestMatch, order: .descending) { [weak self] result in
            switch result {
            case .success(let response):
                self?.output.data(text: text, respositories: .success(response.items))
            case .failure(let error):
                self?.output.data(text: text, respositories: .failure(error))
            }
        }
    }

}
