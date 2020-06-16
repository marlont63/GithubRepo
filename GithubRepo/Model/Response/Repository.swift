//
//  Repo.swift
//  GithubRepo
//
//  Created by Marlon Raschid Tavarez Parra on 12/06/2020.
//  Copyright © 2020 Marlon Raschid Tavarez Parra. All rights reserved.
//

import Foundation
import UIKit

struct Repository: Codable {
    var id: Int
    var name: String
    var fullName: String
    var description: String?
    var language: String?
    var createdAt: String?
    var updatedAt: String?
    var owner:owner
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case fullName = "full_name"
        case description
        case language
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case owner
    }
}

struct owner: Codable {
    var avatarUrl:String?
    var type: String
    
    enum CodingKeys: String, CodingKey {
        case avatarUrl = "avatar_url"
        case type
    }
}
