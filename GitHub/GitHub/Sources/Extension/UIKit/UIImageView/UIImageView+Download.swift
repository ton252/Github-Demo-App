//
//  UIImageView+Download.swift
//  GitHub
//
//  Created by Anton Polyakov on 08/08/2019.
//  Copyright © 2019 ton252. All rights reserved.
//

import UIKit

extension UIImageView {
    
    func image(for url: URL?, placeholder: UIImage? = nil) {
        guard let url = url else {
            self.image = placeholder
            return
        }
    
        ImageService.shared.image(for: url) { [weak self] image in
            self?.image = image
        }
    }
    
}
