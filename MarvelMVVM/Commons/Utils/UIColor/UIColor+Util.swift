//
//  UIColor+Util.swift
//  MarvelMVVM
//
//  Created by Daniel Rocha on 05/03/20.
//  Copyright © 2020 Daniel Rocha. All rights reserved.
//

import UIKit

extension UIColor {
    public convenience init(r: CGFloat, g: CGFloat, b: CGFloat, alpha: CGFloat) {
        self.init(red: r/255, green: g/255, blue: b/255, alpha: 1.0)
    }
    
    static let priamryDarkRed = UIColor(r: 205, g: 46, b: 39, alpha: 1.0)
}
