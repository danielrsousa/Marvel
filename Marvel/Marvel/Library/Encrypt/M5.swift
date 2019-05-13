//
//  M5.swift
//  Marvel
//
//  Created by Daniel Sousa on 20/04/18.
//  Copyright © 2018 Daniel Sousa. All rights reserved.
//

import Foundation


class M5 {
    
    static func md5(string: String) -> String {
        let messageData = string.data(using:.utf8)!
        var digestData = Data(count: Int(CC_MD5_DIGEST_LENGTH))
        
        _ = digestData.withUnsafeMutableBytes {digestBytes in
            messageData.withUnsafeBytes {messageBytes in
                CC_MD5(messageBytes, CC_LONG(messageData.count), digestBytes)
            }
        }
        
        let string = digestData.map { String(format: "%02hhx", $0) }.joined()
        
        return string
    }
    
}
