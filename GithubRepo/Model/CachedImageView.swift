//
//  CachedImageView.swift
//  GithubRepo
//
//  Created by Marlon Raschid Tavarez Parra on 17/06/2020.
//  Copyright © 2020 Marlon Raschid Tavarez Parra. All rights reserved.
//

import Foundation
import UIKit

class CachedImageView: UIImageView {    
    private var imageEndPoint: String?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
