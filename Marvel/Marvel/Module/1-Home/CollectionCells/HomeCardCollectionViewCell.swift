//
//  HomeCardCollectionViewCell.swift
//  Marvel
//
//  Created by Daniel Sousa on 20/04/18.
//  Copyright © 2018 Daniel Sousa. All rights reserved.
//

import UIKit
import AlamofireImage

class HomeCardCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var title: UILabel!
    
    func configureCell(character: Character) {
        if let url = URL(string: character.thumbnail) {
            image.af_setImage(withURL: url,
                              placeholderImage: nil,
                              filter: nil, progress: nil,
                              progressQueue: .main,
                              imageTransition: UIImageView.ImageTransition.crossDissolve(0.5),
                              runImageTransitionIfCached: false,
                              completion: nil)
        }
        
        title.text = character.name
    }
    
    override var isHighlighted: Bool {
        didSet {
            UIView.animate(withDuration: 0.1) {
                let scale: CGFloat = 0.9
                self.transform = self.isHighlighted ? CGAffineTransform(scaleX: scale, y: scale) : .identity
            }
        }
    }
}
