//
//  RepositoriesRepositoriesPresenter.swift
//  GitHub
//
//  Created by Anton Polyakov on 07/08/2019.
//  Copyright © 2019 ton252. All rights reserved.
//

import Foundation

class RepositoriesPresenter {

    weak var view: RepositoriesViewInput!
    var interactor: RepositoriesInteractorInput!
    var router: RepositoriesRouterInput!
    
    var searchText: String = ""
    let throttler = Throttler()
    var viewModels: [ViewModel] { return self.repositories }
    
    private var repositories = [RepositoryViewModel]()

}

// MARK: - RepositoriesViewOutput

extension RepositoriesPresenter: RepositoriesViewOutput {

    func viewDidLoad() {
        self.view.set(title: Text.Repositories.title)
        self.view.reloadZero(viewModel: .startSearch)
    }
    
    func search(text: String) {
        self.throttler.throttle { [weak self] in
            self?.interactor.search(text: text)
        }
    }
    
    func didSelectRowAt(_ indexPath: IndexPath) {
        let repository = repositories[indexPath.row]
        self.router.showSummary(viewModel: SummaryViewModel(viewModel: repository))
    }
    
    func retry() {
        self.search(text: self.searchText)
    }

}

// MARK: - RepositoriesInteractorOutput

extension RepositoriesPresenter: RepositoriesInteractorOutput {
    
    func data(text: String, respositories: Result<[Repository], ServiceError>) {
        self.searchText = text
        
        guard !text.isEmpty else {
            self.repositories = []
            self.view.reloadZero(viewModel: .startSearch)
            
            return
        }
        
        switch respositories {
        case .success(let repositories):
            let viewModels = repositories.compactMap() { RepositoryViewModel(model: $0, searchText: text) }
            self.repositories = viewModels
            
            if self.repositories.count > 0 {
                self.view.reloadData()
            } else {
                self.view.reloadZero(viewModel: .empty)
            }
        case .failure(_):
            self.repositories = []
            self.view.reloadZero(viewModel: .unknown)
        }
    }

}
