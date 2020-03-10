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
        coordinators.append(homeCoordinator)
        let homeController = homeCoordinator.navigationController
                
        homeController.tabBarItem = UITabBarItem(tabBarSystemItem: .search, tag: 0)

//        let secondViewController = secondVC()
//
//        secondViewController.tabBarItem = UITabBarItem(tabBarSystemItem: .more, tag: 1)

        let controllers = [homeController]

        viewControllers = controllers
    }
    

}
