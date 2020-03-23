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
    var childCoordinator: BaseCoordinator?
    var stop: (() -> Void)?
    
    init(_ viewController: UIViewController) {
        self.viewController = viewController
    }
}

extension BaseCoordinator: ViewModelDelegate {
    func finishCoordinator() {
        stop?()
    }
}
