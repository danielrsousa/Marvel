//
//  CommicsService.swift
//  MarvelMVVM
//
//  Created by Daniel Rocha on 10/03/20.
//  Copyright © 2020 Daniel Rocha. All rights reserved.
//

import Foundation

struct CommicsApi: ServiceProtocol {
    var api: ApiProtocol
    
    init(api: ApiProtocol) {
        self.api = api
    }
    
    
    func fetchCommics(offSet: Int) {
        
    }
}
