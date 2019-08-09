//
//  BaseNavigationViewController.swift
//  GitHub
//
//  Created by Anton Polyakov on 08.08.2019.
//  Copyright © 2019 ton252. All rights reserved.
//

import UIKit

class BaseNavigationViewController: UINavigationController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupColors()
        self.navigationBar.isTranslucent = false
    }
    
    func setupColors() {
        let scheme = ColorScheme.default
        self.view.tintColor = scheme.text
        self.navigationBar.titleTextAttributes = [.foregroundColor: scheme.text]
        self.navigationBar.barTintColor = scheme.primary
    }
    
}
