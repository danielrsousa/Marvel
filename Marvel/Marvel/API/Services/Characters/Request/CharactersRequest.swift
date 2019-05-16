//
//  TopServiceRequest.swift
//  TopGamesPAN
//
//  Created by Daniel Sousa on 29/03/18.
//  Copyright © 2018 Daniel Sousa. All rights reserved.
//


import Foundation

/**
 Conforms to Equatable. Mainly used to assert Unit tests results
 */
func ==(lhs: CharactersRequest, rhs: CharactersRequest) -> Bool {
    return lhs.url == rhs.url
}

class CharactersRequest: AbstractRequest {
    
    /**
     Conforms to AbstractRequest
     */
    override func toDictionary() -> [String : Any]? {
        return nil
    }

}
