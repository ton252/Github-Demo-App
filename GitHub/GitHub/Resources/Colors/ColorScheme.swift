//
//  ColorScheme.swift
//  GitHub
//
//  Created by Anton Polyakov on 09.08.2019.
//  Copyright © 2019 ton252. All rights reserved.
//

import UIKit

struct ColorScheme {
    let text: UIColor
    let primary: UIColor
    let secondary: UIColor
    let separator: UIColor
    let background: UIColor
    
    static let `default` = ColorScheme.colorScheme(for: .default)
}

fileprivate extension ColorScheme {
    
    private static func colorScheme(for pallet: Palette) -> ColorScheme  {
        return ColorScheme(
            text: pallet.black,
            primary: pallet.orange,
            secondary: pallet.blue,
            separator: pallet.grey,
            background: pallet.white)
    }
    
}
