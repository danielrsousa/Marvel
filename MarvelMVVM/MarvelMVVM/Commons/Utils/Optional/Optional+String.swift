//
//  String+Utils.swift
//  MarvelMVVM
//
//  Created by Daniel Rocha on 10/03/20.
//  Copyright © 2020 Daniel Rocha. All rights reserved.
//

import Foundation

extension Optional where Wrapped == String {
    var unwrapped: String {
        guard let string = self else {
            return ""
        }
        return string
    }
}
