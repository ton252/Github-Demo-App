//
//  RepositoriesRepositoriesRouter.swift
//  GitHub
//
//  Created by Anton Polyakov on 07/08/2019.
//  Copyright © 2019 ton252. All rights reserved.
//

import UIKit

class RepositoriesRouter: BaseRouter, RepositoriesRouterInput {

    func showSummary(viewModel: SummaryViewModel) {
        let viewController = SummaryConfigurator().configureModule(viewModel: viewModel)
        self.show(viewController: viewController)
    }
    
}
