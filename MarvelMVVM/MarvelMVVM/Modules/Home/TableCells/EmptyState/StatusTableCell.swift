//
//  EmptyStateTableCell.swift
//  MarvelMVVM
//
//  Created by Daniel Rocha on 3/17/20.
//  Copyright © 2020 Daniel Rocha. All rights reserved.
//

import UIKit

class StatusTableCell: UITableViewCell {
    
    enum StatusMessages: String {
        case empty = "Character not fount\nTry to search for another character"
        case genericError = "Sorry, an error occoured please try again"
        case none = ""
    }
    
    @IBOutlet weak var label: UILabel!
    
    func setup(status: StatusMessages){
        label.text = status.rawValue
    }
}
