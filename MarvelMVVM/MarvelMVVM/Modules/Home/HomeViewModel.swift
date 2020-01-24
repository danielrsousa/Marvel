//
//  HomeViewModel.swift
//  MarvelMVVM
//
//  Created by Daniel Rocha on 1/22/20.
//  Copyright © 2020 Daniel Rocha. All rights reserved.
//

import Foundation

class HomeViewModel {
    
    weak var coordinatorDelegate: HomeCoordinatorDelegate?
    
    func select() {
        coordinatorDelegate?.didOpenDetail(self)
    }
    
}
