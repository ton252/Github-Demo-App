//
//  Cancelable.swift
//  GitHub
//
//  Created by Anton Polyakov on 07/08/2019.
//  Copyright © 2019 ton252. All rights reserved.
//

import Foundation

protocol Cancelable {
    func cancel()
}

extension URLSessionDataTask: Cancelable {
    //
}
