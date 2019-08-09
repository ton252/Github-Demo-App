//
//  RepositoriesRepositoriesConfigurator.swift
//  GitHub
//
//  Created by Anton Polyakov on 07/08/2019.
//  Copyright © 2019 ton252. All rights reserved.
//

import UIKit

class RepositoriesConfigurator {

    func configureModule() -> UIViewController {
        let viewController = RepositoriesViewController()
        let router = RepositoriesRouter(viewController: viewController)
        let presenter = RepositoriesPresenter()
        
        let service = GithubService()
        let interactor = RepositoriesInteractor(service: service)
        
        presenter.router = router
        presenter.view = viewController
        presenter.interactor = interactor
        
        viewController.output = presenter
        
        interactor.output = presenter

        return viewController
    }

}
