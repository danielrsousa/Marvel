//
//  AbstractRouter.swift
//  a-lodjinha
//
//  Created by Daniel Sousa on 18/04/18.
//  Copyright © 2018 Daniel Rocha. All rights reserved.
//

import UIKit

class AbstractRouter {
    
    weak var viewController: UIViewController?
    
    required init(viewController: UIViewController) {
        self.viewController = viewController
    }
    
}
