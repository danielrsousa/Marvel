//
//  DataResponse.swift
//  a-lodjinha
//
//  Created by Daniel Sousa on 18/04/18.
//  Copyright © 2018 Daniel Rocha. All rights reserved.
//

import Foundation
import ObjectMapper

/**
 Conforms to Equatable. Mainly used to assert Unit tests results
 */
func ==(lhs: ResultCharactersResponse, rhs: ResultCharactersResponse) -> Bool {
    if lhs.id == nil || rhs.id == nil {
        return false
    }
    
    return lhs.id! == rhs.id!
}


class ResultCharactersResponse: ResponseProtocol {
    
    var id: Int?
    var name: String?
    var description: String?
    var thumbnail : ThumbnailResponse?
    
    // MARK: Conforms to Encodable
    private enum CodingKeys: String, CodingKey {
        case id
        case name
        case description
        case thumbnail
    }
    
    func encode(to encoder: Encoder) throws {
        var values = encoder.container(keyedBy: CodingKeys.self)
        try values.encode(id, forKey: .id)
        try values.encode(name, forKey: .name)
        try values.encode(description, forKey: .description)
        try values.encode(thumbnail, forKey: .thumbnail)
    }
}

class ThumbnailResponse: ResponseProtocol {
    static func == (lhs: ThumbnailResponse, rhs: ThumbnailResponse) -> Bool {
        return true
    }
    
    
    var path: String?
    var extensionThumb: String?
    
    // MARK: Conforms to Encodable
    private enum CodingKeys: String, CodingKey {
        case path
        case extensionThumb = "extension"
    }
    
    func encode(to encoder: Encoder) throws {
        var values = encoder.container(keyedBy: CodingKeys.self)
        try values.encode(path, forKey: .path)
        try values.encode(extensionThumb, forKey: .extensionThumb)
    }
    
}
