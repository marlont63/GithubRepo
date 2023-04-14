//
//  MapDetailsViewController.swift
//  GithubRepo
//
//  Created by Marlon Tavarez Parra on 13/4/23.
//  Copyright © 2023 Marlon Raschid Tavarez Parra. All rights reserved.
//

import Foundation
import UIKit
import GoogleMaps

class MapDetailsViewController: UIViewController {
    @IBOutlet weak var latLabel: UILabel!
    @IBOutlet weak var lonLabel: UILabel!
    var marker: GMSMarker!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
    }
    
    func setUI() {
        latLabel.text = "LAT".localized() + ": " + marker.position.latitude.description
        lonLabel.text = "LON".localized() + ": " + marker.position.longitude.description
    }
}
