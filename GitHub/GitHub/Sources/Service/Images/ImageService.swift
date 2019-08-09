//
//  ImageService.swift
//  GitHub
//
//  Created by Anton Polyakov on 08/08/2019.
//  Copyright © 2019 ton252. All rights reserved.
//

import UIKit

class ImageService: ImageServiceProtocol {
    
    private let cache = NSCache<NSString, UIImage>()
    
    // MARK: - Public Properties
    
    let session: URLSession
    let completionQueue: DispatchQueue
    
    static let shared = ImageService()
    
    // MARK: - Initializers
    
    init(session: URLSession = .shared, completionQueue: DispatchQueue = .main) {
        self.session = session
        self.completionQueue = completionQueue
    }
    
    @discardableResult
    func downloadImage(with url: URL, cache: Bool = true, completion: ((UIImage?) -> Void)?) -> Cancelable {
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, responseURL, error in
            guard let `self` = self else { return }
            
            var downloadedImage: UIImage? = nil
            
            if cache, let data = data, let image = UIImage(data: data)  {
                downloadedImage = image
                self.cache.setObject(image, forKey: url.absoluteString as NSString)
            }
            
            self.completionQueue.async {
                completion?(downloadedImage)
            }
        }
        
        task.resume()
        
        return task
    }
    
    @discardableResult
    func image(for url: URL, completion: ((UIImage?) -> Void)?) -> Cancelable {
        if let image = self.cache.object(forKey: url.absoluteString as NSString) {
            self.completionQueue.async { completion?(image) }
            return CancelableStub()
        } else {
            return self.downloadImage(with: url, cache: true) { [weak self] image in
                self?.completionQueue.async { completion?(image) }
            }
        }
    }
    
    func clearCache() {
        self.cache.removeAllObjects()
    }
    
}

fileprivate final class CancelableStub: Cancelable {
    func cancel() { }
}
