//
//  HomeItemTableCell.swift
//  MarvelMVVM
//
//  Created by Daniel Rocha on 1/22/20.
//  Copyright © 2020 Daniel Rocha. All rights reserved.
//

import UIKit

class HomeItemTableCell: UITableViewCell {

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var imageTeste: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        containerView.layer.cornerRadius = 15.0
        containerView.clipsToBounds = true
//        imageTeste.hero.isEnabled = true
//        containerView.hero.isEnabled = true
//        imageTeste.hero.id = "teste"
//        containerView.hero.id = "containerView"
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
