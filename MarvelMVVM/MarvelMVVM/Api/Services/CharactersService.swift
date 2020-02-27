//
//  CharactersService.swift
//  MarvelMVVM
//
//  Created by Daniel Rocha on 27/02/20.
//  Copyright © 2020 Daniel Rocha. All rights reserved.
//

import Foundation

fileprivate struct CharactersRequest: ApiRequestProtocol {
    var baseURL: String {
        return ServicesInfo.baseURL
    }
    
    var path: String {
        return ServicesInfo.EndPoints.Caracters.caracters.rawValue
    }
    
    var method: HTTPMethod {
        return .post
    }
    
    var headers: [String : String]?
    
    var parameters: [String : Any]
}

struct CharactersService {
    let api = Api()
    
    func fetchCharacters(offSet: Int, completion: @escaping (Result<[Character], ApiError>) -> Void) {
        let request = CharactersRequest(parameters: [:])
        
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
