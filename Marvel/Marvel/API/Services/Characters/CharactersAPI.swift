//
//  TwitchAPI.swift
//  TopGamesPAN
//
//  Created by Daniel Sousa on 29/03/18.
//  Copyright © 2018 Daniel Sousa. All rights reserved.
//

import Foundation

class CharactersAPI {
    
    var networking: NetworkingProtocol
    
    init(networking: NetworkingProtocol) {
        self.networking = networking
    }
    
    func getCharacters(offset: Int,
                       success: @escaping NetworkSuccessBlock<CharactersResponse>,
                       failure: @escaping NetworkFailureBlock) {
        
        return getCharacters(url: ConstantsService.EndPoint.MarvelCharacters,
                             offset: "\(offset)",
                             success: success,
                             failure: failure)
        
    }
    
    func getCharacters(name: String,
                       offset: Int,
                       success: @escaping NetworkSuccessBlock<CharactersResponse>,
                       failure: @escaping NetworkFailureBlock) {
        
        return getCharacters(url: ConstantsService.EndPoint.MarvelCharactersByName,
                             offset: "\(offset)",
                             name: name.replacingOccurrences(of: " ", with: "%20"),
                             success: success,
                             failure: failure)
        
    }
    
    private func getCharacters(url: String,
                               offset: String,
                               name: String? = nil,
                               success: @escaping NetworkSuccessBlock<CharactersResponse>,
                               failure: @escaping NetworkFailureBlock) {
        let charactersRequest: CharactersRequest = CharactersRequest()
        
        let marvel = MarvelAPIUtil.getHashAndTimestamp()
        
        var buildUrl = ""
  
        if let name = name {
            buildUrl = String.init(format: url,
                                   ConstantsService.ApiKey,
                                   marvel.timestamp,
                                   marvel.hash,
                                   offset,
                                   name)
        } else {
            buildUrl = String.init(format: url,
                                   ConstantsService.ApiKey,
                                   marvel.timestamp,
                                   marvel.hash,
                                   offset)
        }
        
        charactersRequest.url = buildUrl
        
        return self.networking.doGet(requestObject: charactersRequest, success: success, failure: failure)
    }
    
}
