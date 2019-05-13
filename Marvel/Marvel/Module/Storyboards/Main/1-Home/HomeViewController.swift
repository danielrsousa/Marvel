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
    
    @IBOutlet weak var searchTextField: UITextField!
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
        
        self.collectionView.delegate = self
        self.collectionView.dataSource  = self
        self.filter.delegate = self
        
        self.presenter?.delegate = self
        self.addRefresh()
        self.load()

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
    
    @IBAction
    func viewTapped(_ sender: UITapGestureRecognizer) {
        self.view.endEditing(true)
    }
    
    @IBAction
    func cardTapped(_ sender: UIButton) {
        self.collectionType = .card
        sender.setImage(UIImage(named: "galery_on"), for: .normal)
        self.listButton.setImage(UIImage(named: "list_off"), for: .normal)
        self.collectionView.reloadData()
    }
    
    @IBAction
    func listTapped(_ sender: UIButton) {
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
        self.presenter?.getCharacters(offset: self.offset)
        self.refresher.endRefreshing()
    }

    
}

extension HomeViewController: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        
        if offsetY > contentHeight - scrollView.frame.size.height {
            
            if let presenter = self.presenter, !presenter.isRequest {
                self.presenter?.getCharacters(offset: self.offset)
            }

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
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
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
            let cell: HomeCardCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "HomeCardCollectionViewCell",
                                                                                      for: indexPath) as! HomeCardCollectionViewCell
            
            cell.configureCell(character: self.characters[indexPath.row])
            
            return cell
        } else {
            
            let cell: HomeListCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "HomeListCollectionViewCell",
                                                                                      for: indexPath) as! HomeListCollectionViewCell
            
            cell.configureCell(character: self.characters[indexPath.row])
            
            return cell
        }
    }
}

extension HomeViewController: HomePresenterDelegate {
    func finishLoadCharacters(characters: [Character]) {
        if self.isRefresh {
            self.characters = []
            self.isRefresh = false
        }
        
        self.characters.append(contentsOf: characters)
        self.notFoundView.isHidden = self.characters.count != 0
        self.offset = self.characters.count + 1
        self.collectionView.reloadData()
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
        return false
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        let newString = (textField.text! as NSString).replacingCharacters(in: range, with: string)
        
        if newString.contains("\n") {
            return true
        }
        
        self.characters = []
        self.offset = 1
        
        if newString == "" {
            self.load()
            return true
        }
        
        self.presenter?.getCharacters(name: newString)
        
        return true
        
    }
}
