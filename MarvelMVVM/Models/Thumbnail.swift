//
//  Thumbnail.swift
//  MarvelMVVM
//
//  Created by Daniel Rocha on 10/03/20.
//  Copyright © 2020 Daniel Rocha. All rights reserved.
//

import Foundation

struct Thumbnail: Codable, Hashable {
    var path: String?
    var extensionThumb: String?
    
    func getUrl() -> URL? {
        let urlString = "\(path.unwrapped).\(extensionThumb.unwrapped)"
        return URL(string: urlString)
    }
    
    enum CodingKeys: String, CodingKey {
        case path
        case extensionThumb = "extension"
    }
}
