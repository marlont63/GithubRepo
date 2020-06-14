//
//  RepositoryDetailViewController.swift
//  GithubRepo
//
//  Created by Marlon Raschid Tavarez Parra on 14/06/2020.
//  Copyright © 2020 Marlon Raschid Tavarez Parra. All rights reserved.
//

import Foundation
import UIKit

class RepositoryDetailViewController: UIViewController {
    
    @IBOutlet weak var repositoryImage: UIImageView!
    @IBOutlet weak var repositoryName: UILabel!
    @IBOutlet weak var repositoryDescription: UILabel!
    @IBOutlet weak var repositoryType: UILabel!
    @IBOutlet weak var repositoryLanguage: UILabel!
    @IBOutlet weak var repositoryCreatedAt: UILabel!
    @IBOutlet weak var repositoryUpdatedAt: UILabel!
    
    var repository:Repository!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUI()
    }
    
    func setUI() {
        
        let language = repository.language ?? "Not available"
        let created = repository.created_at?.formatDate() ?? "Not available"
        let updated = repository.updated_at?.formatDate() ?? "Not available"
        
        self.repositoryName.text = repository.name
        self.repositoryDescription.text = repository.description
        self.repositoryType.text = "Type: \(repository.owner.type)"
        self.repositoryLanguage.text = "Language: \(language)"
        self.repositoryCreatedAt.text = "Created: \(created)"
        self.repositoryUpdatedAt.text = "Updated: \(updated)"
        
        if let imageURL = repository.owner.avatar_url {
            if let url = URL(string: imageURL) {
                
                let data = try? Data(contentsOf: url)

                if let imageData = data {
                    let image = UIImage(data: imageData)
                    
                    self.repositoryImage.image = image
                }
            }
        }
    }
}
