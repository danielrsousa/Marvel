//
//  APIInjector.swift
//
//  Created by Daniel Rocha on 3/29/18.
//  Copyright © 2018 Daniel Sousa. All rights reserved.
//

import Foundation

class APIInjector {
    
    private static var injection: [String : AnyObject] = [:]
    
    static func initialize() {
        /*
         Services injection
         */
        
        let networking: NetworkingProtocol = Networking()
        self.injection[String(describing: NetworkingProtocol.self)] = networking
        
        let charactersAPI: CharactersAPI = CharactersAPI(networking: networking)
        self.injection[String(describing: CharactersAPI.self)] = charactersAPI        
        
    }
    
    static func inject<T>(_ classType: AnyClass) -> T {
        return self.injection[String(describing: classType)] as! T
    }
    
}
