//
//  HomeCoordinator.swift
//  MarvelMVVM
//
//  Created by Daniel Rocha on 1/22/20.
//  Copyright © 2020 Daniel Rocha. All rights reserved.
//

import UIKit

class HomeCoordinator: BaseCoordinator {
    
    // MARK: - Properties
    var navigationController: UINavigationController {
        let nav = MNavigationController(rootViewController: viewController)
        return nav
    }
    
    // MARK: - Initializers
    init() {
        let service = CharactersService(api: Api())
        let viewModel = HomeViewModel(service: service)
        let viewController = HomeViewController(viewModel: viewModel)
        super.init(viewController)
        viewModel.delegate = self
    }
}

// MARK: - Conforms HomeViewModelDelegate
extension HomeCoordinator: HomeViewModelDelegate {
    func didOpenDetail(_ character: Character) {
        childCoordinator = DetailCoordinator()
        childCoordinator?.finish = { [weak self] in
            self?.childCoordinator = nil
        }
        viewController.navigationController?.pushViewController(childCoordinator!.viewController, animated: true)
    }
        
}
