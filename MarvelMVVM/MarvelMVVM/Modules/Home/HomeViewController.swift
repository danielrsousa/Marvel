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
    private var searchController: UISearchController?
    
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
        navigationItem.largeTitleDisplayMode = .always
        registerCells()
        setupSerachBar()
        loadCharacters()
    }

    //MARK: - Internal Methods
    func setupSerachBar(){
        searchController = UISearchController(searchResultsController: nil)
        searchController?.searchBar.delegate = self
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        definesPresentationContext = true
        
        // Needed to display large title the first time
        self.tableView.contentInsetAdjustmentBehavior = .never
    }
    
    func registerCells() {
        tableView.register(HomeHeaderCell.nib, forHeaderFooterViewReuseIdentifier: "HomeHeaderCell")
        tableView.register(HomeItemTableCell.self)
        tableView.register(HomeCategoryTableCell.self)
    }

    func loadCharacters(animated: Bool = false, completion: (() -> Void)? = nil) {
        viewModel?.fetchBy(success: { [weak self] in
            guard let self = self else { return }
            animated ? self.reloadTableWithAnimation() : self.tableView.reloadData()
            completion?()
        })
    }
    
    func reloadTableWithAnimation() {
        let range = NSMakeRange(0, self.tableView.numberOfSections)
        let sections = NSIndexSet(indexesIn: range)
        self.tableView.reloadSections(sections as IndexSet, with: .fade)
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
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard viewModel?.showHeader() == true else { return nil }
        
        guard let headerCell = tableView.dequeueReusableHeaderFooterView(
            withIdentifier: "HomeHeaderCell"
        ) as? HomeHeaderCell else { return nil }
        
        headerCell.delegate = self
        headerCell.initFilter(viewModel?.searchText ?? "")
        return headerCell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {      
        return 213
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        guard viewModel?.showHeader() == true else { return 0.0 }
        return 60
    }
}

extension HomeViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        if offsetY > contentHeight - scrollView.frame.size.height {
            loadCharacters()
        }
    }
}

extension HomeViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let name = searchBar.text, !name.isEmpty {
            viewModel?.fetchBy(name, success: { [weak self] in
                self?.reloadTableWithAnimation()
                self?.tableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: true)
            })
        }
        searchController?.isActive = false
    }
}

extension HomeViewController: HomeHeaderCellDelegate {
    func disableFilter() {
        viewModel?.disableFilter()
        loadCharacters(animated: true) { [weak self] in
            self?.tableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: true)
        }
    }
}
