//
//  SearchRepository.swift
//  GithubRepo
//
//  Created by Marlon Raschid Tavarez Parra on 13/06/2020.
//  Copyright © 2020 Marlon Raschid Tavarez Parra. All rights reserved.
//

import Foundation

struct SearchRepositoryResponse: Codable {
    var total_count: Int
    var incomplete_results: Bool
    var items: [Repository]
}
