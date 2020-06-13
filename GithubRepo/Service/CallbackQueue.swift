//
//  CallbackQueue.swift
//  GithubRepo
//
//  Created by Marlon Raschid Tavarez Parra on 13/06/2020.
//  Copyright © 2020 Marlon Raschid Tavarez Parra. All rights reserved.
//

import Foundation

enum CallbackQueue {
    case main
    case current
    case operationQueue(OperationQueue)
    case dispatchQueue(DispatchQueue)
    
    public func execute(closure: @escaping () -> Void) {
        switch self {
        case .main:
            DispatchQueue.main.async {
                closure()
            }
        case .current:
            closure()
        case .operationQueue(let operationQueue):
            operationQueue.addOperation {
                closure()
            }
        case .dispatchQueue(let dispatchQueue):
            dispatchQueue.async {
                closure()
            }
        }
    }
}
