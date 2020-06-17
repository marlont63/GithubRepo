//
//  RepositoryTableViewCell.swift
//  GithubRepo
//
//  Created by Marlon Raschid Tavarez Parra on 14/06/2020.
//  Copyright © 2020 Marlon Raschid Tavarez Parra. All rights reserved.
//

import Foundation
import UIKit

class RepositoryTableViewCell: UITableViewCell {
    
    @IBOutlet weak var repositoryImage: UIImageView!
    
    @IBOutlet weak var repositoryName: UILabel!
    @IBOutlet weak var repositoryDescription: UILabel!
    
    let requestService = RequestService()
    
    func config(repository:Repository) {
        self.repositoryName.text = repository.name
        self.repositoryDescription.text = repository.description
        
        if let imageURL = repository.owner.avatarUrl {
            if let url = URL(string: imageURL) {
                
                loadImage(from: url)
            }
        }
    }
    
    private func loadImage(from url: URL) {
                
        func setImage(_ image: UIImage) {
            DispatchQueue.main.async {
                self.repositoryImage.image = image
            }
        }
        
        if let imageFromCache = UIImage.imageCache.object(forKey: url.absoluteString as AnyObject) as? UIImage {
            setImage(imageFromCache)
            return
        }
        
        UIImage.cacheImage(from: url) { (image) in
            guard let imageFromCache = image else {
                return
            }
            setImage(imageFromCache)
        }
    }
}
