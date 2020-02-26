//
//  HomeCategoryTableCell.swift
//  MarvelMVVM
//
//  Created by Daniel Rocha on 1/22/20.
//  Copyright © 2020 Daniel Rocha. All rights reserved.
//

import UIKit

class HomeCategoryTableCell: UITableViewCell {

    @IBOutlet weak var collectionView: UICollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        registerCell()
    }
    
    func registerCell() {
        let nib = UINib(nibName: "CardCollectionCell", bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: "CardCollectionCell")
    }
    
}

extension HomeCategoryTableCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CardCollectionCell", for: indexPath)
        return cell
    }
}

extension HomeCategoryTableCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.row == 1 {
             return CGSize(width: UIScreen.main.bounds.width, height: 300)
        }
        
        let width = UIScreen.main.bounds.width / 2.3
        
        let height = 1 + CGFloat.random(in: 0..<0.9)
        
        return CGSize(width: width, height: width * height)
    }
}
