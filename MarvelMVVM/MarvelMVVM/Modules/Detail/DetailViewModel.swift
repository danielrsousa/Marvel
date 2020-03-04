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
    
    //MARK: - Properties
    weak var delegate: DetailViewModelDelegate?
    let character: Character
    
    //MARK: - Initializers
    init(character: Character) {
        self.character = character
    }
    
    //MARK: - Internal Methods
    func finish() {
        delegate?.finishCoordinator()
    }
}
