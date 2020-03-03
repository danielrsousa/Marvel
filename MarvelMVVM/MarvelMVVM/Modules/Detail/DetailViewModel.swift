//
//  DetailViewModel.swift
//  MarvelMVVM
//
//  Created by Daniel Rocha on 03/03/20.
//  Copyright © 2020 Daniel Rocha. All rights reserved.
//

import Foundation

protocol DetailViewModelDelegate: AnyObject, ViewModelDelegate {}

class DetailViewModel {
    
    weak var delegate: DetailViewModelDelegate?
    
    func finish() {
        delegate?.finishCoordinator()
    }
}
