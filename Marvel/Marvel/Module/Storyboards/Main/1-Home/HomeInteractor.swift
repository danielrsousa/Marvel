//
//  HomeInteractor.swift
//  Marvel
//
//  Created by Daniel Sousa on 20/04/18.
//  Copyright © 2018 Daniel Sousa. All rights reserved.
//

import UIKit

class HomeInteractor {
    
    private var characterAPI: CharactersAPI

    init(charactersAPI: CharactersAPI) {
        self.characterAPI = charactersAPI
    }
    
    func getCharacters(offset: Int,
                       success: @escaping (_ characters: [Character]) -> (),
                       failure: @escaping (NetworkingError?) -> ()) {
        
        self.characterAPI.getCharacters(offset: offset, success: { (response) in
            
            if let _response = response {
                
                let character = CharacterMapper.convertResponseToCharacterList(response: _response)
                
                success(character)
            } else {
                failure(NetworkingError(errorCode: "-1", errorMessage: "Falha ao carregar personagens"))
            }
            
        }) { (error) in
            failure(error)
        }
        
        
    }
    
    func getCharacters(name: String,
                       success: @escaping (_ characters: [Character]) -> (),
                       failure: @escaping (NetworkingError?) -> ()) {
        
        self.characterAPI.getCharacters(name: name, success: { (response) in
            
            if let _response = response {
                
                let character = CharacterMapper.convertResponseToCharacterList(response: _response)
                
                success(character)
            } else {
                failure(NetworkingError(errorCode: "-1", errorMessage: "Falha ao carregar personagens"))
            }
            
        }) { (error) in
            failure(error)
        }
    }
}
