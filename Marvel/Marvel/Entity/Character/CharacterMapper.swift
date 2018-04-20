//
//  CharacterMapper.swift
//  Marvel
//
//  Created by Daniel Sousa on 20/04/18.
//  Copyright © 2018 Daniel Sousa. All rights reserved.
//

import Foundation

class CharacterMapper {
    
    static func convertResponseToCharacterList(response: CharactersResponse) -> [Character] {
        
        guard let result = response.results else {
            return []
        }
        
        var characters: [Character] = []
        
        for c in result {
            
            let path = c.thumbnail?.path ?? ""
            let extensionThumb = c.thumbnail?.extensionThumb ?? ""
            
            let thumbnail = path + "." + extensionThumb
            
            let character: Character = Character(id: c.id ?? 0,
                                                 name: c.name ?? "",
                                                 description: c.description ?? "",
                                                 thumbnail: thumbnail)
            
            characters.append(character)
        }
        
        return characters
        
    }
    
}
