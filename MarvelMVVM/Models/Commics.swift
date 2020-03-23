//
//  Commics.swift
//  MarvelMVVM
//
//  Created by Daniel Rocha on 10/03/20.
//  Copyright © 2020 Daniel Rocha. All rights reserved.
//

import Foundation

struct Commics: Decodable {
    let id: Int?
    let title: String?
    let description: String?
    let thumbnail : Thumbnail?
}
