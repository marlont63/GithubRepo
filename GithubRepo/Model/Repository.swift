//
//  Repo.swift
//  GithubRepo
//
//  Created by Marlon Raschid Tavarez Parra on 12/06/2020.
//  Copyright © 2020 Marlon Raschid Tavarez Parra. All rights reserved.
//

import Foundation


class Repository: Codable {
    var id: Int
    var name: String
    var full_name: String
    var description: String?
}

