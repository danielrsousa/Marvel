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
    let character: Character
    private let service: CommicsApi
    private var offSet = 0
    private var fetchMore = true
    private(set) var commics: [Commics] {
        didSet {
            self.offSet = self.commics.count
        }
    }
    
    weak var delegate: DetailViewModelDelegate?
    
    //MARK: - Initializers
    init(character: Character, service: CommicsApi) {
        self.service = service
        self.character = character
        self.commics = []
    }
    
    //MARK: - Internal Methods
    func fetchCommics(success: @escaping () -> Void) {
        guard let id = character.id, fetchMore else { return }
        fetchMore = false
        service.fetchCommics(id: id) { [weak self] (result) in
            guard let self = self else { return }
            DispatchQueue.main.async {
                switch result {
                case .success(let commics):
                    let filter = commics.filter { !$0.thumbnail.debugDescription.contains("image_not_available") }
                    self.commics.append(contentsOf: filter)
                    success()
                case.failure(_):
                    success()
                }
                self.fetchMore = true
            }
        }
    }
    
    //MARK: - Internal Methods
    func finish() {
        delegate?.finishCoordinator()
    }
}
