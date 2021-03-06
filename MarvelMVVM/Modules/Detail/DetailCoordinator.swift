//
//  DetailCoordinator.swift
//  MarvelMVVM
//
//  Created by Daniel Rocha on 03/03/20.
//  Copyright © 2020 Daniel Rocha. All rights reserved.
//

import UIKit

class DetailCoordinator: BaseCoordinator {
    
    var navigationController: UINavigationController {
        let nav = MNavigationController(rootViewController: viewController)
        return nav
    }
    
    // MARK: - Initializers
    init(character: Character) {
        let service = CommicsApi(api: Api.shared)
        let viewModel = DetailViewModel(character: character, service: service)
        let viewController = DetailViewController(viewModel: viewModel)
        super.init(viewController)
        viewModel.delegate = self
    }
}

//MARK: - Conforms DetailViewModelDelegate
extension DetailCoordinator: DetailViewModelDelegate {}

