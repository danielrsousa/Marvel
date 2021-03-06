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

    static let width = UIScreen.main.bounds.width / 2
    static let height = width * 1.54
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setup(commic: Commics?) {
        guard let commic = commic else { return }
        image.kf.indicatorType = .activity
        image.kf.setImage(with: commic.thumbnail?.getUrl())
    }

}
