//
//  HomeCoordinator.swift
//  MarvelMVVM
//
//  Created by Daniel Rocha on 1/22/20.
//  Copyright © 2020 Daniel Rocha. All rights reserved.
//

import UIKit

protocol HomeCoordinatorDelegate: AnyObject {
    func didOpenDetail(_ viewModel: HomeViewModel)
}

class HomeCoordinator: BaseCoordinator {
    // MARK: - Initializers
    init() {
        var viewModel = HomeViewModel()
        let viewController = HomeViewController(viewModel: viewModel)
        super.init(viewController)
        viewModel.coordinatorDelegate = self
    }
}

// MARK: - HomeCoordinator
extension HomeCoordinator: HomeCoordinatorDelegate {
    func didOpenDetail(_ viewModel: HomeViewModel) {

    }
}
