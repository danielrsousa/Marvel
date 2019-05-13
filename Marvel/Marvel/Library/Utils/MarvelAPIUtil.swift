//
//  MarvelAPIUtil.swift
//  Marvel
//
//  Created by Daniel Sousa on 13/05/19.
//  Copyright © 2019 Daniel Sousa. All rights reserved.
//

import Foundation

class MarvelAPIUtil {
    
    static func getHashAndTimestamp() -> (timestamp: String, hash: String ) {
        let ts = String.init(format: "%f", NSDate().timeIntervalSince1970).replacingOccurrences(of: ".", with: "")
        let string = String.init(format: "%@%@%@", ts, ConstantsService.PrivateKey, ConstantsService.ApiKey)
        return (timestamp: ts, hash: M5.md5(string: string))
    }
}
