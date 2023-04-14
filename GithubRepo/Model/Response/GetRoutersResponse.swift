//
//  GetRoutersResponse.swift
//  GithubRepo
//
//  Created by Marlon Raschid Tavarez Parra on 11/04/2023.
//  Copyright © 2023 Marlon Raschid Tavarez Parra. All rights reserved.
//

import Foundation
import UIKit

struct GetRoutersResponse: Codable {
    var id: String
    var name: String
    var x: Double
    var y: Double
    var scheduledArrival: Int?
    var locationType: Int?
    var taxable: Bool
    var companyZoneId: Int
    var lat: Double?
    var lon: Double?
}
