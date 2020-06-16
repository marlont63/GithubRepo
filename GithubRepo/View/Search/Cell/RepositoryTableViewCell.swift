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
    
    func config(repository:Repository) {
        self.repositoryName.text = repository.name
        self.repositoryDescription.text = repository.description
        
        if let imageURL = repository.owner.avatar_url {
            if let url = URL(string: imageURL) {
                
                let requestService = RequestService()
                requestService.downloadImage(from: url, success: { (avatarImage) in
                    DispatchQueue.main.async {
                        self.repositoryImage.image = avatarImage
                    }
                    
                }) { (GithubError) in
                    print(GithubError.localizedDescription)
                }
            }
        }
    }
}
