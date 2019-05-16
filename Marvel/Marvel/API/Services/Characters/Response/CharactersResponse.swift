//
//  ExampleResponse.swift
//  TopGamesPAN
//
//  Created by Daniel Sousa on 09/03/18.
//  Copyright © 2018 Daniel Sousa. All rights reserved.
//

import Foundation
import ObjectMapper

struct CharactersResponse: ResponseProtocol {
    
    static func == (lhs: CharactersResponse, rhs: CharactersResponse) -> Bool {
        return true
    }
    
    var results: [ResultCharactersResponse]?
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        let data = try values.nestedContainer(keyedBy: DataKeys.self, forKey: .data)
        results = try data.decode([ResultCharactersResponse].self, forKey: .results)
    }
    
    // MARK: Conforms to Encodable
    enum CodingKeys: String, CodingKey {
        case status
        case data
    }
    
    enum DataKeys: String, CodingKey {
        case results
    }
    
    func encode(to encoder: Encoder) throws {
        var values = encoder.container(keyedBy: CodingKeys.self)
        var data = values.nestedContainer(keyedBy: DataKeys.self, forKey: .data)
        try data.encode([results], forKey: .results)
    }
    
}
