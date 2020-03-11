//
//  CommicCollectionCell.swift
//  MarvelMVVM
//
//  Created by Daniel Rocha on 11/03/20.
//  Copyright © 2020 Daniel Rocha. All rights reserved.
//

import UIKit
import Kingfisher

class CommicCollectionCell: UICollectionViewCell {

    @IBOutlet weak var image: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setup(commic: Commics?) {
        guard let commic = commic else { return }
        image.kf.setImage(with: commic.thumbnail?.getUrl())
    }

}
