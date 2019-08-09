//
//  SummarySummaryInteractor.swift
//  GitHub
//
//  Created by Anton Polyakov on 07/08/2019.
//  Copyright © 2019 ton252. All rights reserved.
//

import Foundation

class SummaryInteractor {

    weak var output: SummaryInteractorOutput!
    let service: GithubServiceProtocol
    
    init(service: GithubServiceProtocol) {
        self.service = service
    }

}

// MARK: - SummaryInteractorInput

extension SummaryInteractor: SummaryInteractorInput {
    
    func languages(owner: String, repo: String, at indexPath: IndexPath) {
        self.service.languages(owner: owner, repo: repo) { [weak self] result in
            self?.output.data(languages: result, at: indexPath)
        }
    }
    
    func readme(owner: String, repo: String, at indexPath: IndexPath) {
        self.service.readme(owner: owner, repo: repo) { [weak self] result in
            self?.output.data(readme: result, at: indexPath)
        }
    }
    
}

