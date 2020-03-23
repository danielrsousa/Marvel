//
//  Characters.swift
//  MarvelMVVM
//
//  Created by Daniel Rocha on 27/02/20.
//  Copyright © 2020 Daniel Rocha. All rights reserved.
//

import Foundation

struct Character: Decodable {
    let id: Int?
    let name: String?
    let description: String?
    let thumbnail : Thumbnail?
}
