//
//  Throttler.swift
//  GitHub
//
//  Created by Anton Polyakov on 07/08/2019.
//  Copyright © 2019 ton252. All rights reserved.
//

import Foundation

class Throttler {
    
    // MARK: - Public Properties
    
    var delay: TimeInterval {
        didSet { self.workItem.cancel() }
    }
    
    // MARK: - Private Properties
    
    private var workItem: DispatchWorkItem = DispatchWorkItem(block: {})
    private var previousRun: Date = Date.distantPast
    private let queue: DispatchQueue
    
    // MARK: - Initializers
    
    init(delay: TimeInterval = 0.7, queue: DispatchQueue = .main) {
        self.delay = delay
        self.queue = queue
    }
    
    // MARK: - Public Methods
    
    func throttle(cancelPrevious: Bool = true, _ block: @escaping () -> Void) {
        if cancelPrevious {
           self.workItem.cancel()
        }
        
        self.workItem = DispatchWorkItem() { [weak self] in
            self?.previousRun = Date()
            block()
        }
        
        let delay = self.previousRun.timeIntervalSinceNow > self.delay ? 0 : self.delay
        self.queue.asyncAfter(deadline: .now() + Double(delay), execute: self.workItem)
    }
    
}
