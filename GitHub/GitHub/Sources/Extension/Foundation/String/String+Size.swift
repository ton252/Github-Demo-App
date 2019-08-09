//
//  String+Size.swift
//  GitHub
//
//  Created by Anton Polyakov on 07/08/2019.
//  Copyright © 2019 ton252. All rights reserved.
//

import UIKit

extension String {
    
    func size(font: UIFont, maxSize: CGSize, maximumNumberOfLines: Int = 0, lineFragmentPadding: CGFloat = 0) -> CGRect {
        let attributes = [NSAttributedString.Key.font: font]
        let string = NSAttributedString(string: self, attributes: attributes)
        return string.size(maxSize: maxSize, maximumNumberOfLines: maximumNumberOfLines, lineFragmentPadding: lineFragmentPadding)
    }
    
}
