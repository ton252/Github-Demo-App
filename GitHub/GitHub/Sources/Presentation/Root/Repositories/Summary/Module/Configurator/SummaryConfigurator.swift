//
//  SummarySummaryConfigurator.swift
//  GitHub
//
//  Created by Anton Polyakov on 07/08/2019.
//  Copyright © 2019 ton252. All rights reserved.
//

import UIKit

class SummaryConfigurator {

    func configureModule(viewModel: SummaryViewModel) -> UIViewController {
        let viewController = SummaryViewController()
        let router = SummaryRouter(viewController: viewController)
        let presenter = SummaryPresenter(viewModel: viewModel)
        let interactor = SummaryInteractor(service: GithubService())
        
        presenter.router = router
        presenter.view = viewController
        presenter.interactor = interactor
        
        viewController.output = presenter
        interactor.output = presenter

        return viewController
    }

}
