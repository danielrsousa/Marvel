//
//  CommicsViewController.swift
//  MarvelMVVM
//
//  Created by Daniel Rocha on 10/03/20.
//  Copyright © 2020 Daniel Rocha. All rights reserved.
//

import UIKit

class CommicsViewController: UIViewController {

    //MARK: - IBOutlets Properties
    @IBOutlet weak var collectionView: UICollectionView!
    
    //MARK: - Private Properties
    private let viewModel: CommicsViewModel?
    
    //MARK: - Initializers
    init(viewModel: CommicsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        self.viewModel = nil
        super.init(coder: coder)
    }
    
    //MARK: - Life Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
    }

}
