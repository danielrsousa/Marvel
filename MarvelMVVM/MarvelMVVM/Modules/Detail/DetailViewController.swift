//
//  DetailViewController.swift
//  MarvelMVVM
//
//  Created by Daniel Rocha on 1/22/20.
//  Copyright © 2020 Daniel Rocha. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

//    @IBOutlet weak var imageTeste: UIImageView!
//    let imageTeste = UIImageView(image: UIImage(named: "teste"))
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var characterDescription: UILabel!
    
    //MARK: - Private Properties
    private let viewModel: DetailViewModel?
    
    //MARK: - Initializers
    init(viewModel: DetailViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        self.viewModel = nil
        super.init(coder: coder)
    }
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        viewModel?.finish()
    }
    
    //MARK: - Internal Methods
    func setupView() {
        var url: URL? {
            let urlString = "\(viewModel?.character.thumbnail?.path ?? "").\(viewModel?.character.thumbnail?.extensionThumb ?? "")"
            return URL(string: urlString)
        }
        image.kf.setImage(with: url)
        name.text = viewModel?.character.name
        characterDescription.text = viewModel?.character.description?.isEmpty == false ? viewModel?.character.description : "Este personagem não possui descrição"
    }
}
