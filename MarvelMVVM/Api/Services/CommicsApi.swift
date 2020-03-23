//
//  CommicsService.swift
//  MarvelMVVM
//
//  Created by Daniel Rocha on 10/03/20.
//  Copyright © 2020 Daniel Rocha. All rights reserved.
//

import Foundation

fileprivate struct CommicsRequest: ApiRequestProtocol {
    var baseURL = ServicesInfo.baseURL
    var path: String
    var method: HTTPMethod  = .get
    var headers: [String : String]?
    var parameters: [String : Any]
}

struct CommicsApi: ServiceProtocol {
    var api: ApiProtocol
    
    init(api: ApiProtocol) {
        self.api = api
    }
    
    func fetchCommics(id: Int, completion: @escaping (Result<[Commics], ApiError>) -> Void) {
        let tuple = CommicsRequest.getHashAndTimestamp()
        
        let path = String.init(
            format: ServicesInfo.EndPoints.Characters.commics.rawValue,
            id,
            ServicesInfo.apiKey,
            tuple.timestamp,
            tuple.hash
        )
        
        let request = CommicsRequest(path: path, parameters: [:])
        
        api.request(request: request, result: {(result: Result<Response<Commics>, ApiError>) in
            switch result {
            case .success(let response):
                completion(.success(response.results))
            case .failure(let error):
                completion(.failure(error))
            }
        })
    }
}
