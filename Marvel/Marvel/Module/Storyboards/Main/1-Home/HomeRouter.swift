//
//  HomeRouter.swift
//  Marvel
//
//  Created by Daniel Sousa on 20/04/18.
//  Copyright © 2018 Daniel Sousa. All rights reserved.
//

import UIKit

class HomeRouter: AbstractRouter {
    
    /**
     It creates all VIPER modules and inject necessary dependencies
     */
    static func viewController() -> UIViewController {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
        
        let r = HomeRouter(viewController: vc)
        let i = HomeInteractor(charactersAPI: APIInjector.inject(CharactersAPI.self))
        let p = HomePresenter(interactor: i, router: r)
        
        vc.presenter = p
        
        let navigationController: UINavigationController = UINavigationController(rootViewController: vc)
        
        return navigationController
    }
    
    /**
     It makes Authentication view the main view of the app
     */
    static func showHomeView() {
        UIApplication.shared.getWindow()?.rootViewController = HomeRouter.viewController()
    }
    
    func goToDetails(character: Character) {
        
        let vc = DetailRouter.viewController()
        vc.character = character
        
        self.viewController?.navigationController?.pushViewController(vc, animated: true)
    }
    
}
