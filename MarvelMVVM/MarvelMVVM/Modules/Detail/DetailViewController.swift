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
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        viewModel?.finish()
    }
}
