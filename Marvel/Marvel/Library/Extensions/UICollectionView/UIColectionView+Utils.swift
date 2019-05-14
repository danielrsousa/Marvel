//
//  UIColectionView+Utils.swift
//  Marvel
//
//  Created by Daniel Sousa on 14/05/19.
//  Copyright © 2019 Daniel Sousa. All rights reserved.
//

import UIKit

public extension UICollectionView {
    
    public func register(_ cell: UICollectionViewCell.Type) {
        let nib = UINib(nibName: cell.identifier, bundle: nil)
        register(nib, forCellWithReuseIdentifier: cell.identifier)
    }
    
}
