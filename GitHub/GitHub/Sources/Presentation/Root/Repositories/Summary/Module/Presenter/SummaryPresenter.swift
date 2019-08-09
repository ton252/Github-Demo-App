//
//  SummarySummaryPresenter.swift
//  GitHub
//
//  Created by Anton Polyakov on 07/08/2019.
//  Copyright © 2019 ton252. All rights reserved.
//

import Foundation

class SummaryPresenter {

    weak var view: SummaryViewInput!
    var interactor: SummaryInteractorInput!
    var router: SummaryRouterInput!
    
    let summary: SummaryViewModel
    
    private(set) var sections: [SummarySectionViewModel] = [
        SummarySectionViewModel(state: .loading(vm: SummaryShimmeringViewModel()), type: .description),
        SummarySectionViewModel(state: .loading(vm: SummaryShimmeringViewModel()), type: .languages),
        SummarySectionViewModel(state: .loading(vm: SummaryShimmeringViewModel()), type: .readme)
    ]
    
    init(viewModel: SummaryViewModel) {
        self.summary = viewModel
    }
    
    private func reloadAllSections() {
        (0..<self.sections.count).forEach() { self.reload(at: IndexPath(row: 0, section: $0)) }
    }
    
    private func reloadLanguages(at indexPath: IndexPath) {
        self.interactor.languages(owner: self.summary.owner, repo: self.summary.name, at: indexPath)
    }
    
    private func reloadReadme(at indexPath: IndexPath) {
        self.interactor.readme(owner: self.summary.owner, repo: self.summary.name, at: indexPath)
    }

}

// MARK: - SummaryViewOutput

extension SummaryPresenter: SummaryViewOutput {

    func viewDidLoad() {
        self.view.intializeData()
        self.reloadAllSections()
    }
    
    func reload(at indexPath: IndexPath) {
        let section = self.sections[indexPath.section]
        
        switch section.type {
        case .description:
            section.state = .rich(vm: SummaryContentViewModel(text: self.summary.description))
        case .languages:
            section.state = .loading(vm: SummaryShimmeringViewModel())
            self.view.reloadRows(at: indexPath)
            self.reloadLanguages(at: indexPath)
        case .readme:
            section.state = .loading(vm: SummaryShimmeringViewModel())
            self.view.reloadRows(at: indexPath)
            self.reloadReadme(at: indexPath)
        }
    }
    
    func didSelectRow(at indexPath: IndexPath) {
        let section = self.sections[indexPath.section]
        
        switch section.state {
        case .error(_):
            self.reload(at: indexPath)
        default:
            break
        }
    }

}

// MARK: - SummaryInteractorOutput

extension SummaryPresenter: SummaryInteractorOutput {
    
    func data(languages: Result<[Language], ServiceError>, at indexPath: IndexPath) {
        let section = self.sections[indexPath.section]
        
        switch languages {
        case .success(let value):
            let lang = value.compactMap { $0.name }
            section.state = .rich(vm: SummaryLanguagesViewModel(languages: lang))
//            let lang = value.compactMap({ $0.name }).joined(separator:", ")
//            section.state = .rich(vm: SummaryContentViewModel(text: lang))
        case .failure(_):
            section.state = .error(vm: .summaryError)
        }
        self.view.reloadRows(at: indexPath)
    }
    
    func data(readme: Result<Readme?, ServiceError>, at indexPath: IndexPath) {
        let section = self.sections[indexPath.section]

        switch readme {
        case .success(let value):
            let text = value?.decodedContent ?? "No README.md"
            section.state = .rich(vm: SummaryContentViewModel(text: text))
        case .failure(_):
            section.state = .error(vm: .summaryError)
        }
        self.view.reloadRows(at: indexPath)
        
    }

}
