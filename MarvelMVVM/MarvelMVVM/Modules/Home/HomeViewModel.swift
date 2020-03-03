//
//  HomeViewModel.swift
//  MarvelMVVM
//
//  Created by Daniel Rocha on 1/22/20.
//  Copyright © 2020 Daniel Rocha. All rights reserved.
//

import Foundation

protocol HomeViewProtocol {
    var characteres: [Character] { get }
    func fetchCharacteres(success: @escaping () -> Void)
}

protocol HomeViewModelDelegate: AnyObject {
    func didOpenDetail(_ viewModel: HomeViewModel)
}

class HomeViewModel {

    //MARK: - Private Properties
    private let service: CharactersService
    private(set) var characteres: [Character] = []
    
    //MARK: - Delegates
    weak var delegate: HomeViewModelDelegate?
    
    //MARK: - Initializers
    init(service: CharactersService) {
        self.service = service
    }
    
    //MARK: - Internal Methods
    func fetchCharacteres(success: @escaping () -> Void) {
        service.fetchCharacters(offSet: 0) { [weak self] (result) in
            DispatchQueue.main.async {
                switch result {
                case .success(let characters):
                    self?.characteres = characters
                    success()
                case.failure(_):
                    success()
                }
            }
        }
    }
    
    func select() {
        delegate?.didOpenDetail(self)
    }
}
