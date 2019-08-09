//
//  Palette.swift
//  GitHub
//
//  Created by Anton Polyakov on 09.08.2019.
//  Copyright © 2019 ton252. All rights reserved.
//

import UIKit

struct Palette {
    let white: UIColor
    let black: UIColor
    let orange: UIColor
    let blue: UIColor
    let grey: UIColor
    
    static let `default` = Palette(
        white: #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0),
        black: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1),
        orange: #colorLiteral(red: 1, green: 0.7861228585, blue: 0, alpha: 1),
        blue: #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1),
        grey: #colorLiteral(red: 0.921431005, green: 0.9214526415, blue: 0.9214410186, alpha: 1))
}
