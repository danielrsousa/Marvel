//
//  DetailRouter.swift
//  Marvel
//
//  Created by Daniel Sousa on 20/04/18.
//  Copyright © 2018 Daniel Sousa. All rights reserved.
//

import UIKit

class DetailRouter: AbstractRouter {
    
    /**
     It creates all VIPER modules and inject necessary dependencies
     */
    static func viewController() -> DetailViewController {
        
     
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
        let r = DetailRouter(viewController: vc)
        let p = DetailPresenter(router: r)
        
        vc.presenter = p
        
        return vc
    }
    
    
}
