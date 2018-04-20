//
//  ExampleResponse.swift
//  TopGamesPAN
//
//  Created by Daniel Sousa on 09/03/18.
//  Copyright © 2018 Daniel Sousa. All rights reserved.
//

import Foundation
import ObjectMapper

/**
 Conforms to Equatable. Mainly used to assert Unit tests results
 */
func ==(lhs: CharactersResponse, rhs: CharactersResponse) -> Bool {
    if lhs.results == nil || rhs.results == nil {
        return false
    }

    return lhs.results! == rhs.results!
}


class CharactersResponse: AbstractResponse {
    
    var results: [ResultCharactersResponse]?
 
    
    /**
     Conforms to AbstractResponse
     */
    override func mapping(map: Map) {
        
        self.results <- map["data.results"]

    }
    
    /**
     Conforms to AbstractResponse
     */
    override func prettyPrint() -> String {
        return "CharactersResponse:\n" +
            "result: \(self.results as Optional) \n"
        
    }
}
