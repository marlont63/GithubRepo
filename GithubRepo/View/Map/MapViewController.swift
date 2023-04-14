//
//  MapViewController.swift
//  GithubRepo
//
//  Created by Marlon Raschid Tavarez Parra on 12/04/2023.
//  Copyright © 2023 Marlon Raschid Tavarez Parra. All rights reserved.
//

import Foundation
import UIKit
import GoogleMaps

protocol MapViewProtocol: BaseViewProtocol {
    func addRoutersToMap(routers: [GetRoutersResponse])
    func goToDetailsView(marker: GMSMarker)
}

class MapViewController: BaseViewController {
    private var mapView: GMSMapView!
    private var presenter:MapPresenter<MapViewController>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = MapPresenter(self)
        presenter?.getRouters()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showMapMarketDetails" {
            if let destionation = segue.destination as? MapDetailsViewController {
                destionation.marker = sender as? GMSMarker
            }
        }
    }
}

extension MapViewController: GMSMapViewDelegate {
    override func loadView() {
        // Load the map at set latitude/longitude and zoom level
        let camera:GMSCameraPosition = GMSCameraPosition.camera(withLatitude:Constants.defaultLat, longitude: Constants.defaultLon, zoom: Constants.defaultMapZoom)
        mapView = GMSMapView(frame: .zero, camera: camera)
        self.view = mapView
        mapView.delegate = self
      }
    
    func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Bool {
        self.presenter?.goToMapMarketDetails(marker: marker)
        return false
    }
    
    func mapView(_ mapView: GMSMapView, idleAt position: GMSCameraPosition) {
        let projection: GMSVisibleRegion = mapView.projection.visibleRegion()
        let topLeftCorner: CLLocationCoordinate2D = projection.farLeft
        let bottomRightCorner: CLLocationCoordinate2D = projection.nearRight
        
        self.presenter?.getRouters(
            lowerLeftLat: topLeftCorner.latitude.description,
            lowerLeftLon: topLeftCorner.longitude.description,
            upperRightLat: bottomRightCorner.latitude.description,
            upperRightLon: bottomRightCorner.longitude.description
        )
    }
}

extension MapViewController: MapViewProtocol {
    func goToDetailsView(marker: GMSMarker) {
        performSegue(withIdentifier: "showMapMarketDetails", sender: marker)
    }
    
    func addRoutersToMap(routers: [GetRoutersResponse]) {
        self.mapView.clear()
        for router in routers {
            if let lat: Double = router.lat, let lon: Double = router.lon {
                let location = CLLocationCoordinate2D(latitude: lat, longitude: lon)
                let marker = GMSMarker()
                marker.position = location
                marker.snippet = router.name
                marker.map = mapView
            }
        }
    }
}
