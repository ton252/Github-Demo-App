//
//  RootRouter.swift
//  GitHub
//
//  Created by Anton Polyakov on 07/08/2019.
//  Copyright © 2019 ton252. All rights reserved.
//

import UIKit

final class RootRouter: BaseRouter {
    
    func setRoot() {
        let viewController = RepositoriesConfigurator().configureModule()
        let navigationViewController = BaseNavigationViewController(rootViewController: viewController)
        self.setRoot(viewController: navigationViewController)
    }
    
}
