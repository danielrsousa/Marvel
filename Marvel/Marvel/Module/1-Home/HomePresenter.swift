//
//  HomePresenter.swift
//  Marvel
//
//  Created by Daniel Sousa on 20/04/18.
//  Copyright © 2018 Daniel Sousa. All rights reserved.
//

import Foundation

protocol HomePresenterDelegate: class {
    func finishLoadCharacters(characters:[Character])
    func showLoading(loading: Bool)
    func showConnectionError()
}

class HomePresenter {
    
    // MARK: - Properties
    
    weak var delegate: HomePresenterDelegate?
    var isRequest = false
    
    private var interactor: HomeInteractor
    private var router: HomeRouter
    
    // MARK: - Initializers
    
    init(interactor: HomeInteractor, router: HomeRouter) {
        self.interactor = interactor
        self.router = router
    }
    
    // MARK: - Internal Methods
    
    func getCharacters(offset: Int) {
        
        self.delegate?.showLoading(loading: true)
        self.isRequest = true
        
        self.interactor.getCharacters(offset: offset, success: { (chatacters) in
            self.isRequest = false
            self.delegate?.finishLoadCharacters(characters: chatacters)
            self.delegate?.showLoading(loading: false)
        }, failure: { (error) in
            self.isRequest = false
            self.delegate?.showConnectionError()
            self.delegate?.showLoading(loading: false)
        })
    }
    
    func getCharacters(name: String,
                       offset: Int) {
        
        if name == "" {
            return
        }
        
        self.delegate?.showLoading(loading: true)
        self.isRequest = true
        
        self.interactor.getCharacters(name: name, offset: offset, success: { (characters) in
            self.isRequest = false
            self.delegate?.finishLoadCharacters(characters: characters)
            self.delegate?.showLoading(loading: false)
        }, failure: { (error) in
            self.isRequest = false
            self.delegate?.showConnectionError()
            self.delegate?.showLoading(loading: false)
        })
    }
    
    func callDetails(character: Character) {
        self.router.goToDetails(character: character)
    }
}
