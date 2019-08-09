//
//  String+Base64.swift
//  GitHub
//
//  Created by Anton Polyakov on 07/08/2019.
//  Copyright © 2019 ton252. All rights reserved.
//

import Foundation

extension String {
    func base64Encoded() -> String? {
        return data(using: .utf8)?.base64EncodedString()
    }
    
    func base64Decoded(options: NSData.Base64DecodingOptions = .ignoreUnknownCharacters) -> String? {
        guard let data = Data(base64Encoded: self, options: options) else { return nil }
        return String(data: data, encoding: .utf8)
    }
}
