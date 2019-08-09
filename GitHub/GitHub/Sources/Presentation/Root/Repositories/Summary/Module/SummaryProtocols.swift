//
//  SummarySummaryProtocols.swift
//  GitHub
//
//  Created by Anton Polyakov on 07/08/2019.
//  Copyright © 2019 ton252. All rights reserved.
//

import Foundation

// MARK: - View

protocol SummaryViewOutput: class {
    var sections: [SummarySectionViewModel] { get }
    var summary: SummaryViewModel { get }
    
    func viewDidLoad()
    func didSelectRow(at indexPath: IndexPath)
}

protocol SummaryViewInput: class {
    func intializeData()
    func reloadData()
    func reloadRows(at indexPath: IndexPath)
}

// MARK: - Interactor

protocol SummaryInteractorInput: class {
    func languages(owner: String, repo: String, at indexPath: IndexPath)
    func readme(owner: String, repo: String, at indexPath: IndexPath)
}

protocol SummaryInteractorOutput: class {
    func data(languages: Result<[Language], ServiceError>, at indexPath: IndexPath)
    func data(readme: Result<Readme?, ServiceError>, at indexPath: IndexPath)
}

// MARK: - Router

protocol SummaryRouterInput: class {
}



