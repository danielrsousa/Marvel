//
//  Characters.swift
//  MarvelMVVM
//
//  Created by Daniel Rocha on 27/02/20.
//  Copyright © 2020 Daniel Rocha. All rights reserved.
//

import Foundation

struct Character: Codable, Hashable {
    var id: Int?
    var name: String?
    var description: String?
    var thumbnail : Thumbnail?
}
