//
//  CoordinatorProtocol.swift
//  MarvelMVVM
//
//  Created by Daniel Rocha on 1/22/20.
//  Copyright © 2020 Daniel Rocha. All rights reserved.
//

import UIKit

class BaseCoordinator {
    var viewController: UIViewController
    
    init(_ viewController: UIViewController) {
        self.viewController = viewController
    }
}

