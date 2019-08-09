//
//  UITableView+RegisterCell.swift
//  GitHub
//
//  Created by Anton Polyakov on 07/08/2019.
//  Copyright © 2019 ton252. All rights reserved.
//

import UIKit

extension UITableView {
    
    func register(cellType: UITableViewCell.Type) {
        self.registerCell(cellType, reuseIdentifier: cellType.defaultReuseIdentifier)
    }
    
    func registerCell(_ viewType: AnyClass, reuseIdentifier: String? = nil, nibName: String? = nil) {
        let sourceBundle = Bundle(for: viewType)
        let reuseIdentifier = reuseIdentifier ?? String(describing: viewType)
        let nibName = nibName ?? reuseIdentifier
        
        if sourceBundle.path(forResource: reuseIdentifier, ofType: "nib") != nil {
            let nib = UINib(nibName: nibName, bundle: sourceBundle)
            self.register(nib, forCellReuseIdentifier: reuseIdentifier)
        } else {
            self.register(viewType, forCellReuseIdentifier: reuseIdentifier)
        }
    }
    
    func dequeueReusableCell(cellType: UITableViewCell.Type, for indexPath: IndexPath) -> UITableViewCell {
        return self.dequeueReusableCell(withIdentifier: cellType.defaultReuseIdentifier, for: indexPath)
    }
    
}

extension UITableViewCell {
    
    static var defaultReuseIdentifier: String {
        return String(describing: self)
    }
    
}
