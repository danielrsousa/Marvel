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
    static func viewController(vc: UIViewController) -> UIViewController {
        
        guard let vc = vc as? HomeViewController else {
            let storyboard = UIStoryboard(name: "Home", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
            
            return vc
        }
        
        let r = HomeRouter(viewController: vc)
        let i = HomeInteractor(charactersAPI: APIInjector.inject(CharactersAPI.self))
        let p = HomePresenter(interactor: i, router: r)
        
        vc.presenter = p
        
        return vc
    }
    
    
}
