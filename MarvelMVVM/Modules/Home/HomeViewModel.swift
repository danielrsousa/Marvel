//
//  HomeViewModel.swift
//  MarvelMVVM
//
//  Created by Daniel Rocha on 1/22/20.
//  Copyright © 2020 Daniel Rocha. All rights reserved.
//

import Foundation

protocol HomeViewModelDelegate: AnyObject {
    func didOpenDetail(_ character: Character)
}

class HomeViewModel: ObservableObject {

    //MARK: - Private Properties
    private let service: CharactersApi?
    private(set) var offSet = 0
    private(set) var fetchMore = true
    private(set) var searchText: String = ""
    
    @Published private(set) var characteres: [Character] {
        didSet {
            self.offSet = self.characteres.count
        }
    }
    var foundAnyCharacter: Bool {
         return characteres.count > 0
    }
    private(set) var fetchState: StatusMessages = .none
    
    //MARK: - Delegates
    weak var delegate: HomeViewModelDelegate?
    
    //MARK: - Initializers
    init(service: CharactersApi?) {
        self.service = service
        self.characteres = []
    }
    
    //MARK: - Internal Methods
    func fetch(by name: String = "") {
        guard name.isEmpty && searchText.isEmpty  else {
            if !name.isEmpty {
                searchText = name
                self.characteres.removeAll()
            }
            
            fetchCharactersBy(searchText)
            return
        }
        
        fetchCharacteres()
    }
    
    func clearFilter() {
        searchText = ""
        fetchState = .none
        characteres.removeAll()
    }
    
    func shoudShowHeader() -> Bool {
        return !searchText.isEmpty
    }
    
    func select(character: Character) {
        delegate?.didOpenDetail(character)
    }
    
    //MARK: - Private Methods
    private func fetchCharacteres() {
        guard fetchMore else { return }
        fetchMore = false
        service?.fetchCharacters(offSet: offSet) { [weak self] (result) in
            DispatchQueue.main.async {
                self?.checkResult(result)
            }
        }
    }
    
    private func fetchCharactersBy(_ name: String) {
        guard fetchMore else { return }
        fetchMore = false
        service?.fetchCharactersBy(name, offSet: offSet) { [weak self] (result) in
            self?.checkResult(result)
        }
    }
    
    private func checkResult(_ result: Result<[Character], ApiError>) {
        switch result {
        case .success(let characteres):
            self.characteres.append(contentsOf: characteres)
            if self.isEmptyState() {
                fetchState = .emptyState
            }
        case.failure(_):
            fetchState = .genericError
        }
        self.fetchMore = true
    }
    
    private func isEmptyState() -> Bool {
        return offSet == 0 && characteres.count == 0
    }
    
    func isLastCharacter(_ character: Character) {
        guard let last = self.characteres.last, last == character else {
            return
        }
        
        fetch()
    }
}
