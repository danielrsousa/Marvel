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
    private let viewModel: HomeViewModel
    private var searchController: UISearchController?
    
    //MARK: - Initializers
    init(viewModel: HomeViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        self.viewModel = HomeViewModel(service: nil)
        super.init(coder: coder)
    }
    
    //MARK: - Life Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Characters"
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
        tableView.register(FilterHeader.nib, forHeaderFooterViewReuseIdentifier: "FilterHeader")
        tableView.register(StatusTableCell.self)
        tableView.register(CharacterTableCell.self)
    }

    func loadCharacters(animated: Bool = false, completion: (() -> Void)? = nil) {
        ProgressHUD.show(tableView)
        viewModel.fetchBy(completion: {
            DispatchQueue.main.async { [weak self] in
                ProgressHUD.dismiss()
                guard let self = self else { return }
                animated ? self.reloadTableWithAnimation() : self.tableView.reloadData()
                completion?()
            }
        })
    }
    
    func reloadTableWithAnimation() {
        tableView.reloadData()
        let range = NSMakeRange(0, self.tableView.numberOfSections)
        let sections = NSIndexSet(indexesIn: range)
        self.tableView.reloadSections(sections as IndexSet, with: .fade)
    }
}

//MARK: - Conforms UITableViewDelegate
extension HomeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.select(character: self.viewModel.characteres[indexPath.row])
    }
}

//MARK: - Conforms UITableViewDataSource
extension HomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard viewModel.foundAnyCharacter else { return 1 }
        return viewModel.characteres.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard viewModel.foundAnyCharacter else {
            return tableView.dequeueReusableCell(of: StatusTableCell.self, for: indexPath) { [weak self] (cell) in
                guard let self = self else { return }
                cell.setup(status: self.viewModel.fetchState)
            }
        }
        
        return tableView.dequeueReusableCell(of: CharacterTableCell.self, for: indexPath) { (cell) in
            cell.setup(character: self.viewModel.characteres[indexPath.row])
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard viewModel.shoudShowHeader() == true else { return nil }
        
        guard let headerCell = tableView.dequeueReusableHeaderFooterView(
            withIdentifier: "FilterHeader"
        ) as? FilterHeader else { return nil }
        
        headerCell.delegate = self
        headerCell.initFilter(viewModel.searchText)
        return headerCell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        guard viewModel.foundAnyCharacter else { return tableView.frame.height }
        return 213
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        guard viewModel.shoudShowHeader() == true else { return 0.0 }
        return 60
    }
}

extension HomeViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard viewModel.foundAnyCharacter else { return }
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
            ProgressHUD.show(tableView)
            viewModel.fetchBy(name, completion: {
                DispatchQueue.main.async { [weak self] in
                    ProgressHUD.dismiss()
                    self?.reloadTableWithAnimation()
                    guard let self = self, self.viewModel.foundAnyCharacter else { return }
                    self.tableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: true)
                }
            })
        }
        searchController?.isActive = false
    }
}

extension HomeViewController: FilterHeaderDelegate {
    func clearFilter() {
        viewModel.clearFilter()
        loadCharacters(animated: true) { [weak self] in
            self?.tableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: true)
        }
    }
}
