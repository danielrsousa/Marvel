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

        struct Caracters {
            fileprivate static let Caracters = "/v1/public/characters?apikey=%@&ts=%@&hash=%@&offset=%i"
            fileprivate static let CaractersByName = "/v1/public/characters?apikey=%@&ts=%@&hash=%@&nameStartsWith=%@"
        }

        static let Marver_Characters = BaseURL + Caracters.Caracters
        static let Marver_CharactersByName = BaseURL + Caracters.CaractersByName
        
    }
    
}
