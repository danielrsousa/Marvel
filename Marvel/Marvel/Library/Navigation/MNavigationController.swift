//
//  MNavigation.swift
//  Marvel
//
//  Created by Daniel Sousa on 13/05/19.
//  Copyright © 2019 Daniel Sousa. All rights reserved.
//

import UIKit

class MNavigationController: UINavigationController {
    
    override func viewDidLoad() {
        defaultNavigationStyle()
    }
    
    func defaultNavigationStyle() {
        navigationBar.barTintColor              = UIColor.navigation
        navigationBar.tintColor                 = .white
        navigationBar.titleTextAttributes       = [NSAttributedString.Key.foregroundColor: UIColor.white]
        navigationBar.isTranslucent             = false
        navigationBar.shadowImage               = UIImage()
        navigationBar.setBackgroundImage(UIImage(), for: .default)
    }
}
