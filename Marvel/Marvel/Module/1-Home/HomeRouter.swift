//
//  HomeRouter.swift
//  Marvel
//
//  Created by Daniel Sousa on 20/04/18.
//  Copyright © 2018 Daniel Sousa. All rights reserved.
//

import UIKit

class HomeRouter: AbstractRouter {
    
    // MARK: - Static Methods
    
    static func viewController() -> UIViewController {

        let vc = HomeViewController()
        let r = HomeRouter(viewController: vc)
        let i = HomeInteractor(charactersAPI: APIInjector.inject(CharactersAPI.self))
        let p = HomePresenter(interactor: i, router: r)
        
        vc.presenter = p
        
        let navigationController: MNavigationController = MNavigationController(rootViewController: vc)
        
        return navigationController
    }
    
    static func showHomeView() {
        UIApplication.shared.getWindow()?.rootViewController = HomeRouter.viewController()
    }
    
    // MARK: - Internal Methods
    
    func goToDetails(character: Character) {
        
        let vc = DetailRouter.viewController()
        vc.character = character
        
        self.viewController?.navigationController?.pushViewController(vc, animated: true)
    }
    
}
