//
//  BaseRouter.swift
//  GitHub
//
//  Created by Anton Polyakov on 07/08/2019.
//  Copyright © 2019 ton252. All rights reserved.
//

import UIKit

class BaseRouter {
    
    /// View Controller
    weak var viewController: UIViewController?
    
    /// Router initializer
    ///
    /// - parameter viewController: see documentation
    ///
    /// - returns: router instance
    init(viewController: UIViewController? = nil) {
        self.viewController = viewController
    }
    
}

// MARK: - Main router displaying view controller methods.

extension BaseRouter {
    
    func setRoot(
        viewController: UIViewController) {
        UIApplication.shared.keyWindow?.rootViewController = viewController
    }
    
    /// Push navigation
    ///
    /// - parameter viewController: view controller, that will be displayed.
    func show(viewController: UIViewController) {
        guard let presenter = self.viewController else {
            return
        }
        
        presenter.navigationController?.pushViewController(viewController, animated: true)
    }
    
    /// Replace all view controllers in stack for new.
    ///
    /// - parameter viewController: view controller, that will be displayed.
    func showOnly(viewController: UIViewController) {
        guard let presenter = self.viewController else {
            return
        }
        
        presenter.navigationController?.viewControllers = [viewController]
    }
    
    /// Modal navigation.
    ///
    /// - parameter viewController: view controller, that will be displayed.
    func presentModally(viewController: UIViewController) {
        guard let presenter = self.viewController else {
            return
        }
        
        presenter.present(viewController, animated: true, completion: .none)
    }
    
    /// Dismiss modal presented view controller.
    func dismiss(animated: Bool = true, completion: VoidClosure? = nil) {
        viewController?.dismiss(animated: animated, completion: completion)
    }
    
    func dismissModalToRoot(animated: Bool = true, completion: VoidClosure? = nil) {
        UIApplication.shared.keyWindow?.rootViewController?.dismiss(animated: animated, completion: completion)
    }
    
    /// Dismiss view controller from navigation stack.
    func pop(animated: Bool = true) {
        if let nav = self.viewController as? UINavigationController {
            _ = nav.popViewController(animated: animated)
        } else {
            _ = self.viewController?.navigationController?.popViewController(animated: animated)
        }
    }
    
    /// Go to root view controller.
    func popToRoot(animated: Bool = true) {
        if let nav = self.viewController as? UINavigationController {
            _ = nav.popToRootViewController(animated: animated)
        } else {
            _ = self.viewController?.navigationController?.popToRootViewController(animated: animated)
        }
    }
    
}
