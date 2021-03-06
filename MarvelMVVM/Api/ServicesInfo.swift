//
//  ServicesList.swift
//  MarvelMVVM
//
//  Created by Daniel Rocha on 27/02/20.
//  Copyright © 2020 Daniel Rocha. All rights reserved.
//

import Foundation

struct ServicesInfo {
    static let baseURL = "https://gateway.marvel.com:443"
    static let apiKey = "00fd0be686cd5ba1a4e10255ad0fabc6"
    static let privateKey = "0fa52519671a52ec881c195f052318b34198d842"
    
    struct EndPoints {
        enum Characters: String {
            case all = "/v1/public/characters?apikey=%@&ts=%@&hash=%@&offset=%i"
            case byName = "/v1/public/characters?apikey=%@&ts=%@&hash=%@&offset=%i&nameStartsWith=%@"
            case commics = "/v1/public/characters/%i/comics?apikey=%@&ts=%@&hash=%@"
        }
    }
}
