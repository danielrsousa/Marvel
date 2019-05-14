//
//  ViewController.swift
//  Marvel
//
//  Created by Daniel Sousa on 20/04/18.
//  Copyright © 2018 Daniel Sousa. All rights reserved.
//

import UIKit

enum CollectionType {
    case card
    case list
}

class HomeViewController: UIViewController {

    
    // Properties
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var filter: UITextField!
    @IBOutlet weak var cardButton: UIButton!
    @IBOutlet weak var listButton: UIButton!
    @IBOutlet weak var notFoundView: UIView!
    private var refresher: UIRefreshControl!
    private var isRefresh: Bool = false
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    
    var presenter: HomePresenter?
    var offset = 0
    var characters: [Character]  = []
    var collectionType : CollectionType = .card
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Marvel"
        
        self.configureCollection()
        self.filter.delegate = self
        
        self.presenter?.delegate = self
        self.addRefresh()
        self.load()

    }
    
    func configureCollection() {
        self.collectionView.delegate = self
        self.collectionView.dataSource  = self
        self.collectionView.register(HomeCardCollectionViewCell.self)
        self.collectionView.register(HomeListCollectionViewCell.self)
    }
    
    func load() {
        self.presenter?.getCharacters(offset: self.offset)
    }
    
    func addRefresh() {
        self.refresher = UIRefreshControl()
        self.collectionView!.alwaysBounceVertical = true
        self.refresher.tintColor = UIColor.black
        self.refresher.addTarget(self, action: #selector(refresh), for: .valueChanged)
        self.collectionView!.addSubview(refresher)
        self.refresher.layer.zPosition = -1;
    }
    
    // MARK: - IBActions
    
    @IBAction func cardTapped(_ sender: UIButton) {
        self.collectionType = .card
        sender.setImage(UIImage(named: "galery_on"), for: .normal)
        self.listButton.setImage(UIImage(named: "list_off"), for: .normal)
        self.collectionView.reloadData()
    }
    
    @IBAction func listTapped(_ sender: UIButton) {
        self.collectionType = .list
        sender.setImage(UIImage(named: "list_on"), for: .normal)
        self.cardButton.setImage(UIImage(named: "galery_off"), for: .normal)
        self.collectionView.reloadData()
    }
    
    @objc
    func update() {
        ConnectionErrorController.shared.dismissConnectionError()
        self.load()
    }
    
    @objc
    func refresh() {
        self.offset = 0
        self.isRefresh = true
        self.getCharacters()
        self.refresher.endRefreshing()
    }

    func getCharacters() {
        if let presenter = self.presenter, !presenter.isRequest, let filter = self.filter.text {
            if filter.isEmpty {
                self.presenter?.getCharacters(offset: self.offset)
            } else {
                self.presenter?.getCharacters(name: filter, offset: self.offset)
            }
        }
    }
    
}

extension HomeViewController: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        
        if offsetY > contentHeight - scrollView.frame.size.height {
            self.getCharacters()
        }
    }
    
}

extension HomeViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let character = self.characters[indexPath.row]
        self.presenter?.callDetails(character: character)
    }
}

extension HomeViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if self.collectionType == .card {
            let width = (UIScreen.main.bounds.size.width / 2) - 15
            return CGSize(width: width, height: width * 1.4)
        } else {
            let width = UIScreen.main.bounds.size.width - 20
            return CGSize(width: width, height: 90)
        }
    }
}

extension HomeViewController: UICollectionViewDataSource {
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.characters.count
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionType == .card {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HomeCardCollectionViewCell",
                                                                for: indexPath) as? HomeCardCollectionViewCell else {
                                                                    return UICollectionViewCell()
            }
            
            cell.configureCell(character: self.characters[indexPath.row])
            
            return cell
        } else {
            
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HomeListCollectionViewCell",
                                                                for: indexPath) as? HomeListCollectionViewCell else {
                                                                    return UICollectionViewCell()
            }
            
            cell.configureCell(character: self.characters[indexPath.row])
            
            return cell
        }
    }
}

extension HomeViewController: HomePresenterDelegate {
    func finishLoadCharacters(characters: [Character]) {
        if self.isRefresh {
            self.characters.removeAll()
            self.isRefresh = false
        }
        
        if offset == 0 {
            self.characters.removeAll()
        }
        
        self.characters.append(contentsOf: characters)
        self.collectionView.reloadData()
        
        self.notFoundView.isHidden = self.characters.count != 0
        self.offset = self.characters.count
        
    }
    
    func showLoading(loading: Bool) {
        loadingIndicator.isHidden = !(loading && self.isRefresh == false)
    }
    
    func showConnectionError() {
        ConnectionErrorController.shared.showConnectionError(target: self, action: #selector(update))
    }
}

extension HomeViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        
        self.offset = 0
        self.getCharacters()
        
        return false
    }
}
