//
//  PrimaryButton.swift
//  MarvelMVVM
//
//  Created by Daniel Rocha on 05/03/20.
//  Copyright © 2020 Daniel Rocha. All rights reserved.
//

import UIKit

class UIPrimaryButton: UIButton {
    override func awakeFromNib() {
        super.awakeFromNib()
        backgroundColor = UIColor.priamryDarkRed
        layer.cornerRadius = frame.height / 2
        setTitleColor(.white, for: .normal)
    }
}
