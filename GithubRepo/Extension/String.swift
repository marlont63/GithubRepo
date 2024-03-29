//
//  String.swift
//  GithubRepo
//
//  Created by Marlon Raschid Tavarez Parra on 14/06/2020.
//  Copyright © 2020 Marlon Raschid Tavarez Parra. All rights reserved.
//

import Foundation

extension String  {
    func formatDate() -> String {
        let dateFormatter: DateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        let formattedDate = dateFormatter.date(from: self) ?? Date()
        dateFormatter.dateFormat = "dd/MM/yyy"
        return dateFormatter.string(from: formattedDate)
    }
    
    func localized() -> String {
        if let path: String = Bundle.main.path(forResource: Constants.defaultLanguage, ofType: "lproj"),
           let bundle: Bundle = Bundle(path: path) {
            return NSLocalizedString(self, tableName: nil, bundle: bundle, value: "", comment: "")
        } else {
            return self
        }
    }
}
