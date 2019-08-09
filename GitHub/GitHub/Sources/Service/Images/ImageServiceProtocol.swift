//
//  ImageServiceProtocol.swift
//  GitHub
//
//  Created by Anton Polyakov on 08/08/2019.
//  Copyright © 2019 ton252. All rights reserved.
//

import UIKit

protocol ImageServiceProtocol {
    
    @discardableResult
    /// Download image for url.
    ///
    /// - Parameters:
    ///   - url: The image url.
    ///   - cache: This property reponds to store image to cache or not.
    ///   - completion: The completion block.
    /// - Returns: The object that can be canceled.
    func downloadImage(with url: URL, cache: Bool, completion: ((UIImage?) -> Void)?) -> Cancelable
    
    @discardableResult
    /// Get image from url, if image is strored in cache this method will return it, if not download image from server.
    ///
    /// - Parameters:
    ///   - url: The image url.
    ///   - completion: The completion block.
    /// - Returns: The object that can be canceled.
    func image(for url: URL, completion: ((UIImage?) -> Void)?) -> Cancelable
    
    func clearCache()
    
}
