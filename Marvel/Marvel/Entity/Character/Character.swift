//
//  Character.swift
//  Marvel
//
//  Created by Daniel Sousa on 20/04/18.
//  Copyright © 2018 Daniel Sousa. All rights reserved.
//

import Foundation

class Character {
    
    public var id: Int
    public var name: String
    public var description: String
    public var thumbnail: String
    
    init(id: Int,
         name: String,
         description: String,
         thumbnail: String) {
        
        self.id = id
        self.name = name
        self.description = description
        self.thumbnail = thumbnail
        
    }
    
}
