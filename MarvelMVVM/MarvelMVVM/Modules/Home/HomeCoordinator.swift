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
    
    // MARK: - Properties
    var navigationController: UINavigationController {
        let nav = MNavigationController(rootViewController: viewController)
        nav.hero.isEnabled = true
        return nav
    }
    
    // MARK: - Initializers
    init() {
        let viewModel = HomeViewModel()
        let viewController = HomeViewController(viewModel: viewModel)
        super.init(viewController)
        viewModel.coordinatorDelegate = self
    }
}

// MARK: - HomeCoordinator
extension HomeCoordinator: HomeCoordinatorDelegate {
    func didOpenDetail(_ viewModel: HomeViewModel) {
        let vc =  DetailViewController()
        
        viewController.navigationController?.pushViewController(vc, animated: true)
    }
        
}
