//
//  DetailViewController.swift
//  Marvel
//
//  Created by Daniel Sousa on 20/04/18.
//  Copyright © 2018 Daniel Sousa. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    var presenter: DetailPresenter?
    
    var character: Character?
    
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var idMarvel: UILabel!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var descriptionHero: UITextView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Detalhes"
        
        guard let character = self.character, let url = URL(string: character.thumbnail) else {
            return
        }

        self.image.af_setImage(withURL: url,
                               placeholderImage: nil,
                               filter: nil, progress: nil,
                               progressQueue: .main,
                               imageTransition: UIImageView.ImageTransition.crossDissolve(0.5),
                               runImageTransitionIfCached: false,
                               completion: nil)
  
        
        self.idMarvel.text = "\(character.id)"
        self.name.text = character.name
        
        self.descriptionHero.text = character.description == "" ? "Não temos mais informações sobre esta personagem" : character.description
    }


}
