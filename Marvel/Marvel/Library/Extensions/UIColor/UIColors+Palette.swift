//
//  UIColors+Palette.swift
//
//  Created by Daniel Rocha on 4/17/18.
//  Copyright © 2018 Daniel Rocha. All rights reserved.
//

import UIKit

extension UIColor {
    
    
    // Colors
    
    /**
     Use this to define base basic colors.
     */
    
    static public var navigation: UIColor {
        return self.createColor(red: 226.0, green: 54.0, blue: 54.0, alpha: 1.0)
    }
    
    static public var customButton: UIColor {
        return self.createColor(red: 226.0, green: 54.0, blue: 54.0, alpha: 1.0)
    }
    
    // MARK: Color helper
    
    /**
     A helper to create a color without using / 255.0 everytime
     */
    static private func createColor(red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat) -> UIColor {
        return UIColor(red: red / 255.0, green: green / 255.0, blue: blue / 255.0, alpha: alpha)
    }
    
}
