//
//  HomeViewModel.swift
//  MarvelMVVM
//
//  Created by Daniel Rocha on 1/22/20.
//  Copyright © 2020 Daniel Rocha. All rights reserved.
//

import Foundation

protocol HomeViewDelegate: AnyObject {
    func updateView()
    func showError()
}

class HomeViewModel {
    
    let service = CharactersService()
    var characteres: [Character] = []
    
    weak var coordinatorDelegate: HomeCoordinatorDelegate?
    weak var viewDelegate: HomeViewDelegate?
    
    func fetchCharacteres() {
        service.fetchCharacters(offSet: 0) { [weak self] (result) in
            DispatchQueue.main.async {
                switch result {
                case .success(let characters):
                    self?.characteres = characters
                    self?.viewDelegate?.updateView()
                case.failure(_):
                    self?.viewDelegate?.showError()
                }
            }
        }
    }
    
    func select() {
        coordinatorDelegate?.didOpenDetail(self)
    }
    
}
