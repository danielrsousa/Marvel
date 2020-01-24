//
//  UIView+Utils.swift
//  MarvelMVVM
//
//  Created by Daniel Rocha on 1/22/20.
//  Copyright © 2020 Daniel Rocha. All rights reserved.
//

import UIKit

let kErrorDequeueCellIdenfier = "Could not dequeue cell with identifier"

public extension UIView {
    static var identifier: String { return String(describing: self) }
    
    static func fromNib<T: UIView>(owner: Any? = nil) -> T {
        guard let result = Bundle.main.loadNibNamed(T.identifier, owner: owner, options: nil)?.first as? T else {
            fatalError("\(kErrorDequeueCellIdenfier): \(T.identifier)")
        }
        return result
    }
    
    static func fromNibNamed(_ name: String, owner: Any? = nil) -> UIView {
        guard let result = Bundle.main.loadNibNamed(name, owner: owner, options: nil)?.first as? UIView else {
            fatalError("\(kErrorDequeueCellIdenfier): \(name)")
        }
        return result
    }
}
