//
//  HomeItemTableCell.swift
//  MarvelMVVM
//
//  Created by Daniel Rocha on 1/22/20.
//  Copyright © 2020 Daniel Rocha. All rights reserved.
//

import UIKit
//import QuartzCore
import Kingfisher

class HomeItemTableCell: UITableViewCell {

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var readMoreButton: UIButton!
    @IBOutlet weak var imageContainerView: UIView!
    @IBOutlet weak var photoImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        containerView.layer.cornerRadius = 25.0
        containerView.layer.addShadow()
        imageContainerView.layer.cornerRadius = 25.0
        imageContainerView.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMaxXMinYCorner]
        readMoreButton.layer.cornerRadius = readMoreButton.frame.height / 2

    }

    override func prepareForReuse() {
        photoImage.image = nil
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setup(character: Character) {
        let urlString = "\(character.thumbnail?.path ?? "").\(character.thumbnail?.extensionThumb ?? "")"
        let url = URL(string: urlString)
        photoImage.kf.setImage(with: url)
    }
}
