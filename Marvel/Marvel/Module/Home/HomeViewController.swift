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

class HomeViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource, HomePresenterDelegate, UITextFieldDelegate {

    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var filter: UITextField!
    @IBOutlet weak var cardButton: UIButton!
    @IBOutlet weak var listButton: UIButton!
    @IBOutlet weak var notFoundView: UIView!
    
    var presenter: HomePresenter?
    var offset = 1
    var characters: [Character]  = []
    var collectionType : CollectionType = .card
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Marvel"
        
        _ = HomeRouter.viewController(vc: self)
        
        self.collectionView.delegate = self
        self.collectionView.dataSource  = self
        self.filter.delegate = self
        
        self.presenter?.delegate = self
        
        self.load()
    }
    
    func load() {
        self.presenter?.getCharacters(offset: self.offset)
    }
    
    @IBAction func viewTapped(_ sender: UITapGestureRecognizer) {
        self.view.endEditing(true)
    }
    
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
    
    // MARK: HomePresenterDelegate
    
    func finishLoadCharacters(characters: [Character]) {
        self.characters.append(contentsOf: characters)

        self.notFoundView.isHidden = self.characters.count != 0
        
        self.collectionView.reloadData()
    }
    
    func showLoading(loading: Bool) {
        if loading {
            LoadingViewController.shared.show()
        } else {
            LoadingViewController.shared.dismiss()
        }
    }
    
    func showConnectionError() {
        ConnectionErrorController.shared.showConnectionError(target: self, action: #selector(update))
    }
    
    func update() {
        ConnectionErrorController.shared.dismissConnectionError()
        self.load()
    }
    
    // MARK: UICollectionViewDataSource

    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if (indexPath.row == (self.characters.count - 5)) {
            self.offset = self.offset + 1
            
            self.presenter?.getCharacters(offset: offset)
        }
    }
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.characters.count
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionType == .card {
            let cell: HomeCardCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "HomeCardCollectionViewCell",
                                                                                      for: indexPath) as! HomeCardCollectionViewCell
            
            AlamofireImageNetworking().requestImage(url: self.characters[indexPath.row].thumbnail, success: { (image) in
                cell.image.image = image
            }) { (error) in
                cell.image = nil
            }
            
            cell.title.text = self.characters[indexPath.row].name
        
            return cell
        } else {
            
            let cell: HomeListCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "HomeListCollectionViewCell",
                                                                                      for: indexPath) as! HomeListCollectionViewCell
            
            AlamofireImageNetworking().requestImage(url: self.characters[indexPath.row].thumbnail, success: { (image) in
                cell.image.image = image
            }) { (error) in
                cell.image = nil
            }
            
            cell.title.text = self.characters[indexPath.row].name
            
            cell.descriptionCharacter.text = self.characters[indexPath.row].description
            
            return cell
        }
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if self.collectionType == .card {
            let width = (UIScreen.main.bounds.size.width / 2) - 15
            return CGSize(width: width, height: width * 1.4)
        } else {
            let width = UIScreen.main.bounds.size.width - 20
            return CGSize(width: width, height: 90)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        <#code#>
    }
    

    // MARK UITextFieldDelegate
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
    
        let newString = (textField.text! as NSString).replacingCharacters(in: range, with: string)
        
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

