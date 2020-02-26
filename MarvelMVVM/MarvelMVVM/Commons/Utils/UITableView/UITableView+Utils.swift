//
//  UITableView+Utils.swift
//  MarvelMVVM
//
//  Created by Daniel Rocha on 1/22/20.
//  Copyright © 2020 Daniel Rocha. All rights reserved.
//

import UIKit

public extension UITableView {
    func register(_ cell: UITableViewCell.Type) {
        let nib = UINib(nibName: cell.identifier, bundle: nil)
        register(nib, forCellReuseIdentifier: cell.identifier)
    }
    
    func dequeueReusableCell<T: UITableViewCell>(
        of class: T.Type,
        for indexPath: IndexPath,
        configure: @escaping ((T) -> Void) = { _ in }) -> UITableViewCell {
            let cell = dequeueReusableCell(withIdentifier: T.identifier, for: indexPath)
            if let typedCell = cell as? T {
                configure(typedCell)
            }
            return cell
    }
}
