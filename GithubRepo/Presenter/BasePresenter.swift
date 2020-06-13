//
//  BasePresenter.swift
//  GithubRepo
//
//  Created by Marlon Raschid Tavarez Parra on 13/06/2020.
//  Copyright © 2020 Marlon Raschid Tavarez Parra. All rights reserved.
//

import Foundation

class BasePresenter<T: BaseViewProtocol> {

    private weak var _view: T?

    var view: T? {
        return _view
    }

    init(_ view: T) {
        _view = view
    }

    deinit {
        _view = nil
    }
}
