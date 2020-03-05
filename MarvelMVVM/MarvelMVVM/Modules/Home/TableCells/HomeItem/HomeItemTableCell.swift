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
    @IBOutlet weak var imageContainerView: UIView!
    @IBOutlet weak var photoImage: UIImageView!
    @IBOutlet weak var resume: UILabel!
    @IBOutlet weak var name: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        containerView.layer.cornerRadius = 25.0
        containerView.layer.addShadow()
        imageContainerView.layer.cornerRadius = 25.0
        imageContainerView.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMaxXMinYCorner]
    }

    override func prepareForReuse() {
        photoImage.image = nil
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setup(character: Character) {
        var url: URL? {
            let urlString = "\(character.thumbnail?.path ?? "").\(character.thumbnail?.extensionThumb ?? "")"
            return URL(string: urlString)
        }
        photoImage.kf.setImage(with: url)
        name.text = character.name
        resume.text = character.description?.isEmpty == false ? character.description : "Este personagem não possui descrição"
    }
}
