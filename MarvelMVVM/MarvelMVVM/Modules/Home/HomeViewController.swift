//
//  HomeViewController.swift
//  MarvelMVVM
//
//  Created by Daniel Rocha on 1/22/20.
//  Copyright © 2020 Daniel Rocha. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    let viewModel: HomeViewModel
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var containerView: UIView!
    
    init(viewModel: HomeViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        self.viewModel.viewDelegate = self
    }
    
    required init?(coder: NSCoder) {
        self.viewModel = HomeViewModel()
        super.init(coder: coder)
        self.viewModel.viewDelegate = self
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerCells()
        title = "Personagens"
        viewModel.fetchCharacteres()
        
        let search = UISearchController(searchResultsController: nil)
//        search.obscuresBackgroundDuringPresentation = true
//        search.hidesNavigationBarDuringPresentation = false
//        search.automaticallyShowsCancelButton = false
//        search.searchBar.searchBarStyle = .minimal
//        search.searchBar.placeholder = "Type something here to search"
        navigationItem.searchController = search
        navigationItem.hidesSearchBarWhenScrolling = false
        
        definesPresentationContext = true
        
        self.tableView.contentInsetAdjustmentBehavior = .never
        
        
    }
    
    func registerCells() {
        tableView.register(TitleTableHeader.self)
        tableView.register(HomeItemTableCell.self)
        tableView.register(HomeCategoryTableCell.self)
    }

}

extension HomeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.select()
    }
}

extension HomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.characteres.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//
//        if indexPath.row == 0 {
//            return tableView.dequeueReusableCell(of: HomeCategoryTableCell.self, for: indexPath)
//        }
        
        let character = viewModel.characteres[indexPath.row]
        return tableView.dequeueReusableCell(of: HomeItemTableCell.self, for: indexPath) { (cell) in
            cell.setup(character: character)
        }
        
    }
    
//    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        guard let headerCell = tableView.dequeueReusableCell(withIdentifier: "TitleTableHeader") as?
//            TitleTableHeader else { return UITableViewCell() }
//
//        return headerCell
//    }
    
//    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
//        return 110
//    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {      
        return 213
    }
    
}

extension HomeViewController: HomeViewDelegate {
    func updateView() {
        tableView.reloadData()
    }
    
    func showError() {
        
    }
    
    
}
