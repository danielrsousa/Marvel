//
//  ServiceProtocol.swift
//  MarvelMVVM
//
//  Created by Daniel Rocha on 03/03/20.
//  Copyright © 2020 Daniel Rocha. All rights reserved.
//

import Foundation

protocol ServiceProtocol {
    var api: ApiProtocol { get set }
    init(api: ApiProtocol)
}
