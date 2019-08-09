//
//  RepositoriesRepositoriesProtocols.swift
//  GitHub
//
//  Created by Anton Polyakov on 07/08/2019.
//  Copyright © 2019 ton252. All rights reserved.
//

import UIKit
import Foundation

// MARK: - View

protocol RepositoriesViewOutput: class {
    var viewModels: [ViewModel] { get }
    
    func viewDidLoad()
    func search(text: String)
    func didSelectRowAt(_ indexPath: IndexPath)
    func retry()
}

protocol RepositoriesViewInput: class {
    func set(title: String)
    func reloadData()
    func reloadZero(viewModel: ReposiztoryZeroViewModel)
}

// MARK: - Interactor

protocol RepositoriesInteractorInput: class {
    func search(text: String)
}

protocol RepositoriesInteractorOutput: class {
    func data(text: String, respositories: Result<[Repository], ServiceError>)
}

// MARK: - Router

protocol RepositoriesRouterInput: class {
    func showSummary(viewModel: SummaryViewModel)
}



