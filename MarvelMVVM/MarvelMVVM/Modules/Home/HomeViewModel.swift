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
    func didOpenDetail(_ character: Character)
}

class HomeViewModel {

    //MARK: - Private Properties
    private let service: CharactersService
    private var offSet = 0
    private var fetchMore = true
    private(set) var characteres: [Character] {
        didSet {
            self.offSet = self.characteres.count
        }
    }
    
    //MARK: - Delegates
    weak var delegate: HomeViewModelDelegate?
    
    //MARK: - Initializers
    init(service: CharactersService) {
        self.service = service
        self.characteres = []
    }
    
    //MARK: - Internal Methods
    func fetchCharacteres(success: @escaping () -> Void) {
        guard fetchMore else { return }
        fetchMore = false
        service.fetchCharacters(offSet: offSet) { [weak self] (result) in
            guard let self = self else { return }
            DispatchQueue.main.async {
                switch result {
                case .success(let characters):
                    self.characteres.append(contentsOf: characters)
                    success()
                case.failure(_):
                    success()
                }
                self.fetchMore = true
            }
        }
    }
    
    func select(character: Character) {
        delegate?.didOpenDetail(character)
    }
}
