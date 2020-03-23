//
//  Response.swift
//  MarvelMVVM
//
//  Created by Daniel Rocha on 27/02/20.
//  Copyright © 2020 Daniel Rocha. All rights reserved.
//

import Foundation

struct Response<T: Decodable>: Decodable {
    let status: String
    let results: [T]
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        status =  try (values.decode(String.self, forKey: .status))
        let data = try values.nestedContainer(keyedBy: CodingKeys.self, forKey: .data)
        results = try data.decode([T].self, forKey: .results)
    }
    
    enum CodingKeys: String, CodingKey {
        case status
        case data
        case results
    }
}
