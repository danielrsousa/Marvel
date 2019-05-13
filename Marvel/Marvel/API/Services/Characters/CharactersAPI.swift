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
                             parm: "\(offset)",
                             success: success,
                             failure: failure)
        
    }
    
    func getCharacters(name: String,
                       success: @escaping NetworkSuccessBlock<CharactersResponse>,
                       failure: @escaping NetworkFailureBlock) {
        
        return getCharacters(url: ConstantsService.EndPoint.MarvelCharactersByName,
                             parm: name.replacingOccurrences(of: " ", with: "%20"),
                             success: success,
                             failure: failure)
        
    }
    
    private func getCharacters(url: String,
                               parm: String,
                               success: @escaping NetworkSuccessBlock<CharactersResponse>,
                               failure: @escaping NetworkFailureBlock) {
        let charactersRequest: CharactersRequest = CharactersRequest()
        
        let marvel = MarvelAPIUtil.getHashAndTimestamp()
        
        let buildUrl = String.init(format: url,
                                   ConstantsService.ApiKey,
                                   marvel.timestamp,
                                   marvel.hash,
                                   parm)
        
        charactersRequest.url = buildUrl
        
        return self.networking.doGet(requestObject: charactersRequest, success: success, failure: failure)
    }
    
}
