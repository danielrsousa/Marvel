//
//  HomeListCollectionViewCell.swift
//  Marvel
//
//  Created by Daniel Sousa on 20/04/18.
//  Copyright © 2018 Daniel Sousa. All rights reserved.
//

import UIKit

class HomeListCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var title: UILabel!
    
    @IBOutlet weak var descriptionCharacter: UILabel!
    
    func configureCell(character: Character) {
        if let url = URL(string: character.thumbnail) {
            image.af_setImage(withURL: url,
                              placeholderImage: nil,
                              filter: nil, progress: nil,
                              progressQueue: .main,
                              imageTransition: UIImageView.ImageTransition.crossDissolve(0.5),
                              runImageTransitionIfCached: true,
                              completion: nil)
        }
        
        title.text = character.name
        descriptionCharacter.text = character.description
    }
}
