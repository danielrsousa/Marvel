//
//  HomeViewController.swift
//  MarvelMVVM
//
//  Created by Daniel Rocha on 1/22/20.
//  Copyright © 2020 Daniel Rocha. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    
    //MARK: - IBOutlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var containerView: UIView!
    
    //MARK: - Private Properties
    private let viewModel: HomeViewModel?
    
    //MARK: - Initializers
    init(viewModel: HomeViewModel) {
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
        title = "Personagens"
        
        registerCells()
        setupSerachBar()
        loadCharacters()
    }

    //MARK: - Internal Methods
    func setupSerachBar(){
        let search = UISearchController(searchResultsController: nil)
        navigationItem.searchController = search
        navigationItem.hidesSearchBarWhenScrolling = false
        definesPresentationContext = true
        
        // Needed to display large title the first time
        self.tableView.contentInsetAdjustmentBehavior = .never
    }
    
    func registerCells() {
        tableView.register(TitleTableHeader.self)
        tableView.register(HomeItemTableCell.self)
        tableView.register(HomeCategoryTableCell.self)
    }

    func loadCharacters() {
        viewModel?.fetchCharacteres(success: { [weak self] in
            self?.tableView.reloadData()
        })
    }
}

//MARK: - Conforms UITableViewDelegate
extension HomeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let character = self.viewModel?.characteres[indexPath.row] else { return }
        viewModel?.select(character: character)
    }
}

//MARK: - Conforms UITableViewDataSource
extension HomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.characteres.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return tableView.dequeueReusableCell(of: HomeItemTableCell.self, for: indexPath) { (cell) in
            guard let character = self.viewModel?.characteres[indexPath.row] else { return }
            cell.setup(character: character)
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {      
        return 213
    }
}
