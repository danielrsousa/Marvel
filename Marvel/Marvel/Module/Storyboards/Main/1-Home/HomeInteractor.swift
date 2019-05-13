//
//  HomeInteractor.swift
//  Marvel
//
//  Created by Daniel Sousa on 20/04/18.
//  Copyright © 2018 Daniel Sousa. All rights reserved.
//

import UIKit

class HomeInteractor {
    
    // MARK: - Private Properties
    
    private var characterAPI: CharactersAPI

    // MARK: - Initializers
    
    init(charactersAPI: CharactersAPI) {
        self.characterAPI = charactersAPI
    }
    
    // MARK: - Internal Methods
    
    func getCharacters(offset: Int,
                       success: @escaping (_ characters: [Character]) -> (),
                       failure: @escaping (NetworkingError) -> ()) {
        
        self.characterAPI.getCharacters(offset: offset, success: { (response) -> () in
            guard let response = response else {
                failure(NetworkingError(errorCode: "-1", errorMessage: "Falha ao carregar personagens"))
                return
            }
            
            let character = CharacterMapper.convertResponseToCharacterList(response: response)
            success(character)

        }, failure: { (error) -> () in
            guard let error = error else {
                failure(NetworkingError(errorType: .unknownError))
                return
            }
            
            failure(error)
        })
        
        
    }
    
    func getCharacters(name: String,
                       success: @escaping (_ characters: [Character]) -> (),
                       failure: @escaping (NetworkingError) -> ()) {
        
        self.characterAPI.getCharacters(name: name, success: { (response) -> () in
            guard let response = response else {
                failure(NetworkingError(errorCode: "-1", errorMessage: "Falha ao carregar personagens"))
                return
            }
                
            let character = CharacterMapper.convertResponseToCharacterList(response: response)
            success(character)
            
        }, failure: { (error) -> () in
            guard let error = error else {
                failure(NetworkingError(errorType: .unknownError))
                return
            }
            
            failure(error)
        })
    }
}
