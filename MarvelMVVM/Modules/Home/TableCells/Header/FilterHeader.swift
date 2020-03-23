//
//  HomeHeaderCell.swift
//  MarvelMVVM
//
//  Created by Daniel Rocha on 05/03/20.
//  Copyright © 2020 Daniel Rocha. All rights reserved.
//

import UIKit

protocol FilterHeaderDelegate: AnyObject {
    func clearFilter()
}

class FilterHeader: UITableViewHeaderFooterView {
    
    @IBOutlet weak var filterButton: UIPrimaryButton!
    weak var delegate: FilterHeaderDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    static var nib: UINib {
        return UINib(nibName: String(describing: self), bundle: nil)
    }
    
    func initFilter(_ filter: String) {
        filterButton.setTitle(filter, for: .normal)
    }
    
    @IBAction func filterAction(_ sender: Any) {
        delegate?.clearFilter()
    }
}
