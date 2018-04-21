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
    
    weak var delegate: HomePresenterDelegate?
    private var interactor: HomeInteractor
    private var router: HomeRouter
    
    //Initialize dependences here
    init(interactor: HomeInteractor, router: HomeRouter) {
        self.interactor = interactor
        self.router = router
    }
    
    func getCharacters(offset: Int) {
        
        self.delegate?.showLoading(loading: true)
        
        self.interactor.getCharacters(offset: offset, success: { (chatacters) in
            self.delegate?.finishLoadCharacters(characters: chatacters)
            self.delegate?.showLoading(loading: false)
        }) { (error) in
            self.delegate?.showConnectionError()
            self.delegate?.showLoading(loading: false)
        }
    }
    
    func getCharacters(name: String) {
        
        if name == "" {
            return
        }
        
        self.delegate?.showLoading(loading: true)
        
        self.interactor.getCharacters(name: name, success: { (characters) in
            self.delegate?.finishLoadCharacters(characters: characters)
            self.delegate?.showLoading(loading: false)
        }) { (error) in
            self.delegate?.showConnectionError()
            self.delegate?.showLoading(loading: false)
        }
    }
    
    func callDetails(character: Character) {
        self.router.goToDetails(character: character)
    }
}
