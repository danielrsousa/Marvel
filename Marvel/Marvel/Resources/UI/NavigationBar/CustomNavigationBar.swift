//
//  CustomNavigationBar.swift
//  a-lodjinha
//
//  Created by Daniel Rocha on 4/17/18.
//  Copyright © 2018 Daniel Rocha. All rights reserved.
//

import UIKit

class CustomNavigationBar:  UINavigationBar {
    
    // MARK: Initializers
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.load()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.load()
    }
    
    
    // MARK: Configuration
    
    /**
     It load the default configuration
     */
    func load() {
        self.barTintColor = UIColor.navigation
        self.tintColor = UIColor.white
    }
    
}
