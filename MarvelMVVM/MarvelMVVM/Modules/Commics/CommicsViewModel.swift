//
//  CommicsViewModel.swift
//  MarvelMVVM
//
//  Created by Daniel Rocha on 10/03/20.
//  Copyright © 2020 Daniel Rocha. All rights reserved.
//

import Foundation

protocol CommicsViewModelDelegate: AnyObject, ViewModelDelegate {}

class CommicsViewModel {
    
    //MARK: - Properties
    weak var delegate: CommicsViewModelDelegate?
    
    //MARK: - Internal Methods
    func finish() {
        delegate?.finishCoordinator()
    }
}
