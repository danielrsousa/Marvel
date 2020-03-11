//
//  MarvelTabBarController.swift
//  MarvelMVVM
//
//  Created by Daniel Rocha on 10/03/20.
//  Copyright © 2020 Daniel Rocha. All rights reserved.
//

import UIKit

class MarvelTabBarController: UITabBarController {

    var coordinators: [BaseCoordinator] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    func setup() {
        let homeCoordinator = HomeCoordinator()
        let commicsCoordinator = CommicsCoordinator()
        coordinators.append(homeCoordinator)
        coordinators.append(commicsCoordinator)
        
        let homeController = homeCoordinator.navigationController
        homeController.tabBarItem = UITabBarItem(tabBarSystemItem: .search, tag: 0)

        let commicsController = commicsCoordinator.viewController
        commicsController.tabBarItem = UITabBarItem(tabBarSystemItem: .more, tag: 1)

        let controllers = [homeController, commicsController]

        viewControllers = controllers
    }
    

}
