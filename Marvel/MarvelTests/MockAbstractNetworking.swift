//
//  MockTwitchAPI.swift
//  TopGamesPANTests
//
//  Created by Daniel Rocha on 3/30/18.
//  Copyright © 2018 Daniel Sousa. All rights reserved.
//

import Foundation
@testable import Marvel
import ObjectMapper

class MockAbstractNetworking: AbstractNetworking {
    
    
    override func doGet<P, R>(requestObject: P, success: @escaping (R?) -> ()?, failure: @escaping (NetworkingError?) -> ()) where P : AbstractRequest, R : AbstractResponse {
        
        let results: [String: Any] = ["id": 1009146, "name": "Abomination (Emil Blonsky)"]
        let data: [String: Any] = ["results": [results]]
        
        let json: [String: Any] = ["data": data]

        guard let responseObject: R = Mapper<R>().map(JSONObject: json) else {
            let error = NetworkingError(errorCode: "-1", errorMessage: "UnitTest")
            failure (error)
            return
        }
        
        success(responseObject)
   
        
    }
    
    
}
