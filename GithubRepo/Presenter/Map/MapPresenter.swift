//
//  MapPresenter.swift
//  GithubRepo
//
//  Created by Marlon Raschid Tavarez Parra on 12/04/2023.
//  Copyright © 2023 Marlon Raschid Tavarez Parra. All rights reserved.
//

import Foundation
import GoogleMaps

class MapPresenter <T: MapViewProtocol>: BasePresenter<T> {
    let requestService: RequestService = RequestService()
    
    func getRouters(
        lowerLeftLat: String = Constants.lowerLeftLat,
        lowerLeftLon: String = Constants.lowerLeftLon,
        upperRightLat: String = Constants.upperRightLat,
        upperRightLon: String = Constants.upperRightLon) {
        let getRoutersRequest: GetRoutersRequest = GetRoutersRequest(
            lowerLeftLat: lowerLeftLat,
            lowerLeftLon: lowerLeftLon,
            upperRightLat: upperRightLat,
            upperRightLon: upperRightLon)
        self.requestService.send(getRoutersRequest) { (getRoutersResponse) in
            self.view?.addRoutersToMap(routers: getRoutersResponse)
        } failure: { (githubError) in
            // Show error msg
        }
    }
    
    func goToMapMarketDetails(marker: GMSMarker) {
        self.view?.goToDetailsView(marker: marker)
    }
}
