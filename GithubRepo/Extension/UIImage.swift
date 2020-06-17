//
//  UIImage.swift
//  GithubRepo
//
//  Created by Marlon Raschid Tavarez Parra on 17/06/2020.
//  Copyright © 2020 Marlon Raschid Tavarez Parra. All rights reserved.
//

import Foundation
import UIKit

let requestService = RequestService()

extension UIImage {
    
    static let imageCache = NSCache<AnyObject, AnyObject>()
    
    static func cacheImage(from url: URL, completion: @escaping (UIImage?) -> ()) {
        
        requestService.downloadImage(from: url, success: { (image) in
            
            DispatchQueue.main.async {
                imageCache.setObject(image, forKey: url.absoluteString as AnyObject)
            }
            
            completion(image)
            
        }) { (githubErro) in
            
            print(githubErro)
        }
    }
}
