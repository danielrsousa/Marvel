//
//  TwitchAPI.swift
//  TopGamesPAN
//
//  Created by Daniel Sousa on 29/03/18.
//  Copyright © 2018 Daniel Sousa. All rights reserved.
//

import Foundation

class CharactersAPI {
    
    var networking: AbstractNetworking
    
    init(networking: AbstractNetworking) {
        self.networking = networking
    }
    
    func getCharacters( offset: Int, success: @escaping (_ responseObject: CharactersResponse?) -> (),
                     failure: @escaping (NetworkingError?) -> ()) {
        
        
        let ts = String.init(format: "%f", NSDate().timeIntervalSince1970).replacingOccurrences(of: ".", with: "")
        
        let string = String.init(format: "%@%@%@", ts, ConstantsService.PrivateKey, ConstantsService.ApiKey)
        
        let hash = M5.md5(string: string)
        
        let charactersRequest: CharactersRequest = CharactersRequest()
        
        let buildUrl = String.init(format: ConstantsService.EndPoint.Marver_Characters, ConstantsService.ApiKey, ts, hash, offset)
        
        charactersRequest.url = buildUrl
        
        return self.networking.doGet(requestObject: charactersRequest, success: success, failure: failure)
        
    }
    
    func getCharacters( name: String, success: @escaping (_ responseObject: CharactersResponse?) -> (),
                        failure: @escaping (NetworkingError?) -> ()) {
        
        
        let ts = String.init(format: "%f", NSDate().timeIntervalSince1970).replacingOccurrences(of: ".", with: "")
        
        let string = String.init(format: "%@%@%@", ts, ConstantsService.PrivateKey, ConstantsService.ApiKey)
        
        let hash = M5.md5(string: string)
        
        let charactersRequest: CharactersRequest = CharactersRequest()
        
        let buildUrl = String.init(format: ConstantsService.EndPoint.Marver_CharactersByName, ConstantsService.ApiKey, ts, hash, name)
        
        charactersRequest.url = buildUrl
        
        return self.networking.doGet(requestObject: charactersRequest, success: success, failure: failure)
        
    }
    
}
