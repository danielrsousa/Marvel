//
//  DetailPresenter.swift
//  Marvel
//
//  Created by Daniel Sousa on 20/04/18.
//  Copyright © 2018 Daniel Sousa. All rights reserved.
//

import Foundation

protocol DetailPresenterDelegate: class {
}

class DetailPresenter {
    
    weak var delegate: DetailPresenterDelegate?
    
    private var router: DetailRouter
    
    //Initialize dependences here
    init(router: DetailRouter) {
        self.router = router
    }
    
    
}

