//
//  NSAttributedString+Size.swift
//  GitHub
//
//  Created by Anton Polyakov on 07/08/2019.
//  Copyright © 2019 ton252. All rights reserved.
//

import UIKit

extension NSAttributedString {
    
    func size(maxSize: CGSize, maximumNumberOfLines: Int = 0, lineFragmentPadding: CGFloat = 0) -> CGRect {
        let textContainer = NSTextContainer(size: maxSize)
        textContainer.maximumNumberOfLines = maximumNumberOfLines
        textContainer.lineFragmentPadding = lineFragmentPadding
        let textStorage = NSTextStorage(attributedString: self)
        
        let layoutManager = NSLayoutManager()
        layoutManager.addTextContainer(textContainer)
        
        textStorage.addLayoutManager(layoutManager)
        
        return CGRect(origin: .zero, size: layoutManager.usedRect(for: textContainer).size)
    }
    
}
