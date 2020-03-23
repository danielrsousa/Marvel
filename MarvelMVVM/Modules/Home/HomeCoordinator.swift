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
        let service = CharactersApi(api: Api.shared)
        let viewModel = HomeViewModel(service: service)
        let viewController = HomeViewController(viewModel: viewModel)
        super.init(viewController)
        viewModel.delegate = self
    }
}

// MARK: - Conforms HomeViewModelDelegate
extension HomeCoordinator: HomeViewModelDelegate {
    func didOpenDetail(_ character: Character) {
        let datailCoordiantor = DetailCoordinator(character: character)
        childCoordinator = datailCoordiantor
        viewController.navigationController?.present(datailCoordiantor.navigationController, animated: true)
        /**
            Necessary use of command CFRunLoopWakeUp(CFRunLoopGetCurrent()) for open the details correctly
            This occours because the main runloop sleep when selectionStyle the tablew is .none. For more informations see in https://stackoverflow.com/questions/21075540/presentviewcontrolleranimatedyes-view-will-not-appear-until-user-taps-again
         */
        CFRunLoopWakeUp(CFRunLoopGetCurrent())
        childCoordinator?.stop = { [weak self] in
            self?.childCoordinator = nil
        }
    }
}
