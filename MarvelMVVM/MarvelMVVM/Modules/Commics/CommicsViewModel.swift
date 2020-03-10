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
    private let service: CommicsApi
    weak var delegate: CommicsViewModelDelegate?
    private var offSet = 0
    private var fetchMore = true
    private(set) var commics: [Commics] {
        didSet {
            self.offSet = self.commics.count
        }
    }
    
    //MARK: - Initializers
    init(service: CommicsApi) {
        self.service = service
        self.commics = []
    }
    
    //MARK: - Internal Methods
    func fetchCommics(success: @escaping () -> Void) {
        guard fetchMore else { return }
        fetchMore = false
        service.fetchCommics(offSet: offSet) { [weak self] (result) in
            guard let self = self else { return }
            DispatchQueue.main.async {
                switch result {
                case .success(let commics):
                    self.commics.append(contentsOf: commics)
                    success()
                case.failure(_):
                    success()
                }
                self.fetchMore = true
            }
        }
    }
    
    func finish() {
        delegate?.finishCoordinator()
    }
}
