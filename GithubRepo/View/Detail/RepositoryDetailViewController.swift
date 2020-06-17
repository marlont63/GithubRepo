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
        
        let language = repository.language ?? "NOT_AVAILABLE".localized()
        let created = repository.createdAt?.formatDate() ?? "NOT_AVAILABLE".localized()
        let updated = repository.updatedAt?.formatDate() ?? "NOT_AVAILABLE".localized()
        
        self.repositoryName.text = repository.name
        self.repositoryDescription.text = repository.description
        self.repositoryType.text = "TYPE".localized() + repository.owner.type
        self.repositoryLanguage.text = "LANGUAGE".localized() + language
        self.repositoryCreatedAt.text = "CREATED".localized() +  created
        self.repositoryUpdatedAt.text = "UPDATE".localized() + updated
        
        if let imageURL = repository.owner.avatarUrl {
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
