//
//  CALayer+Utils.swift
//  MarvelMVVM
//
//  Created by Daniel Rocha on 21/02/20.
//  Copyright © 2020 Daniel Rocha. All rights reserved.
//

import UIKit

extension CALayer {
    func addShadow(radius: CGFloat = 10.0,
                   offSet: CGSize = .zero,
                   color: UIColor = .gray,
                   opacity: Float = 0.6) {
        self.shadowColor = color.withAlphaComponent(0.4).cgColor
        self.shadowRadius = radius
        self.shadowOffset = offSet
        self.shadowOpacity = opacity
        self.masksToBounds = false
    }
    
    func round() {
        
    }
}
