//
//  InitialRouter.swift
//  Marvel
//
//  Created by Daniel Rocha on 24/08/18.
//  Copyright © 2018 Daniel Sousa. All rights reserved.
//

import UIKit

class InitialRouter {
    
    // MARK: Shared instance
    
    static let shared = InitialRouter()
    
    // MARK: Initializer
    
    private init() {
    }
    
    // MARK: Routing
    
    /**
     It redirects the app to the right initial flow
     */
    func showInitialView() {
        HomeRouter.showHomeView()
    }
    
}
