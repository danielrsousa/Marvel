//
//  TitleTableHeader.swift
//  MarvelMVVM
//
//  Created by Daniel Rocha on 1/22/20.
//  Copyright © 2020 Daniel Rocha. All rights reserved.
//

import UIKit

class TitleTableHeader: UITableViewCell {
    @IBOutlet weak var circularView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        circularView.layer.cornerRadius = 25.0
        circularView.clipsToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
