//
//  JSONDecoder.swift
//  GithubRepo
//
//  Created by Marlon Raschid Tavarez Parra on 12/06/2020.
//  Copyright © 2020 Marlon Raschid Tavarez Parra. All rights reserved.
//

import Foundation
import UIKit

extension JSONDecoder {
    func decode<T: Decodable>(_ type: T.Type, fromURL url:String, completion: @escaping (T) -> Void) {
        guard let url = URL(string: url) else {fatalError("Invalid URL passed.") }
        
        DispatchQueue.global().async {
            do {
                let data = try Data(contentsOf: url)
                let downloadedData = try self.decode(type, from:data)
    
                DispatchQueue.main.async {
                    completion(downloadedData)
                }
                
            } catch {
                print(error.localizedDescription)
            }
        }
    }
}
