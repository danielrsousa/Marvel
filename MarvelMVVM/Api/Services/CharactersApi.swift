//
//  CharactersService.swift
//  MarvelMVVM
//
//  Created by Daniel Rocha on 27/02/20.
//  Copyright © 2020 Daniel Rocha. All rights reserved.
//

import Foundation

fileprivate struct CharactersRequest: ApiRequestProtocol {
    var baseURL = ServicesInfo.baseURL
    var path: String
    var method: HTTPMethod  = .get
    var headers: [String : String]?
    var parameters: [String : Any]
}

class CharactersApi: ServiceProtocol {

    var api: ApiProtocol
    
    required init(api: ApiProtocol) {
        self.api = api
    }
    
    func fetchCharacters(offSet: Int, completion: @escaping (Result<[Character], ApiError>) -> Void) {
        let tuple = CharactersRequest.getHashAndTimestamp()
        
        let path = String.init(
            format: ServicesInfo.EndPoints.Characters.all.rawValue,
            ServicesInfo.apiKey,
            tuple.timestamp,
            tuple.hash,
            offSet
        )
        
        let request = CharactersRequest(path: path, parameters: [:])
        
        api.request(request: request, result: {(result: Result<Response<Character>, ApiError>) in
            switch result {
            case .success(let response):
                completion(.success(response.results))
            case .failure(let error):
                completion(.failure(error))
            }
        })
    }
    
    func fetchCharactersBy(_ name: String, offSet: Int, completion: @escaping (Result<[Character], ApiError>) -> Void) {
        let tuple = CharactersRequest.getHashAndTimestamp()
        
        let nameInURLFormat = name.replacingOccurrences(of: " ", with: "%20")
        
        let path = String.init(
            format: ServicesInfo.EndPoints.Characters.byName.rawValue,
            ServicesInfo.apiKey,
            tuple.timestamp,
            tuple.hash,
            offSet,
            nameInURLFormat
        )
        
        let request = CharactersRequest(path: path, parameters: [:])
        
        api.request(request: request, result: {(result: Result<Response<Character>, ApiError>) in
            switch result {
            case .success(let response):
                completion(.success(response.results))
            case .failure(let error):
                completion(.failure(error))
            }
        })
    }
}
