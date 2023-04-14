//
//  GetRoutersRequest.swift
//  GithubRepo
//
//  Created by Marlon Raschid Tavarez Parra on 11/04/2023.
//  Copyright © 2023 Marlon Raschid Tavarez Parra. All rights reserved.
//

import Foundation

class GetRoutersRequest {
    var lowerLeftLat: String
    var lowerLeftLon: String
    var upperRightLat: String
    var upperRightLon: String
    
    init(lowerLeftLat: String, lowerLeftLon: String, upperRightLat: String, upperRightLon: String) {
        self.lowerLeftLat = lowerLeftLat
        self.lowerLeftLon = lowerLeftLon
        self.upperRightLat = upperRightLat
        self.upperRightLon = upperRightLon
    }
}

extension GetRoutersRequest: GithubApiRequest {
    typealias Response = GetRoutersResponse
    var path: URL {
        let getRouterURL: URL? = URL(string: baseURL.absoluteString + "?lowerLeftLatLon=\(lowerLeftLat),\(lowerLeftLon)&upperRightLatLon=\(upperRightLat),\(upperRightLon)")
        return getRouterURL ?? baseURL
    }
}
