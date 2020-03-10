//
//  CommicsCoordinator.swift
//  MarvelMVVM
//
//  Created by Daniel Rocha on 10/03/20.
//  Copyright © 2020 Daniel Rocha. All rights reserved.
//

import Foundation

class CommicsCoordinator: BaseCoordinator {
    
    // MARK: - Initializers
    init() {
        let viewModel = CommicsViewModel()
        let viewController = CommicsViewController(viewModel: viewModel)
        super.init(viewController)
    }
}
