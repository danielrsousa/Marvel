//
//  ConstantsService+EndPoint.swift
//  TopGamesPAN
//
//  Created by Daniel Sousa on 29/03/18.
//  Copyright © 2018 Daniel Sousa. All rights reserved.
//

import Foundation

extension ConstantsService {
    
    struct EndPoint {

        private struct Caracters {
            static let Caracters = "/v1/public/characters?apikey=%@&ts=%@&hash=%@&offset=%@"
            static let CaractersByName = "/v1/public/characters?apikey=%@&ts=%@&hash=%@&offset=%@&nameStartsWith=%@"
        }

        static let MarvelCharacters = BaseURL + Caracters.Caracters
        static let MarvelCharactersByName = BaseURL + Caracters.CaractersByName
        
    }
    
}
