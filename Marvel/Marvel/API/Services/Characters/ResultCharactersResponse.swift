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


class ResultCharactersResponse: AbstractResponse {
    
    var id: Int?
    var name: String?
    var description: String?
    var thumbnail : ThumbnailResponse?
    
    
    /**
     Conforms to AbstractResponse
     */
    override func mapping(map: Map) {
        
        self.id <- map["id"]
        self.name <- map["name"]
        self.description <- map["description"]
        self.thumbnail <- map["thumbnail"]
        
    }
    
    /**
     Conforms to AbstractResponse
     */
    override func prettyPrint() -> String {
        return "ResultCharactersResponse:\n" +
        "id: \(self.id as Optional) \n" +
        "name: \(self.name as Optional) \n" +
        "description: \(self.description as Optional) \n" +
        "thumbnail: \(self.thumbnail as Optional) \n"
    }
}

class ThumbnailResponse: AbstractResponse {
    
    var path: String?
    var extensionThumb: String?
    
    
    /**
     Conforms to AbstractResponse
     */
    override func mapping(map: Map) {
        
        self.path <- map["path"]
        self.extensionThumb <- map["extension"]
        
    }
    
    /**
     Conforms to AbstractResponse
     */
    override func prettyPrint() -> String {
        return "ResultCharactersResponse:\n" +
            "path: \(self.path as Optional) \n" +
            "extensionThumb: \(self.extensionThumb as Optional) \n"
    }
    
}
