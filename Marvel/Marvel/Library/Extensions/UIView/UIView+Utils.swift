//
//  UIView+Utils.swift
//  Marvel
//
//  Created by Daniel Sousa on 14/05/19.
//  Copyright © 2019 Daniel Sousa. All rights reserved.
//

import UIKit

let kErrorDequeueCellIdenfier = "Could not dequeue cell with identifier"

public extension UIView {
    public static var identifier: String { return String(describing: self) }
    
    public static func fromNib<T: UIView>(owner: Any? = nil) -> T {
        guard let result = Bundle.main.loadNibNamed(T.identifier, owner: owner, options: nil)?.first as? T else {
            fatalError("\(kErrorDequeueCellIdenfier): \(T.identifier)")
        }
        return result
    }
}
