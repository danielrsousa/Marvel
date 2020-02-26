//
//  MNavigationController.swift
//  MarvelMVVM
//
//  Created by Daniel Rocha on 24/01/20.
//  Copyright © 2020 Daniel Rocha. All rights reserved.
//

import UIKit

class MNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }

    private func setup() {
        transparentNavigation()
    }
    
    private func transparentNavigation() {
//        navigationBar.prefersLargeTitles = true
//        navigationItem.largeTitleDisplayMode = .never
        
        navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationBar.shadowImage = UIImage()
        navigationBar.isTranslucent = true
        view.backgroundColor = .clear
        navigationBar.tintColor = .white
        navigationBar.titleTextAttributes = [
            NSAttributedString.Key.foregroundColor: UIColor.white,
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 20, weight: .light)
        ]
        
        navigationBar.largeTitleTextAttributes = [
            NSAttributedString.Key.foregroundColor: UIColor.white,
        ]
    }
    
    private func gradientNavigaiton() {
//        navigationBar.prefersLargeTitles = true
//        navigationItem.largeTitleDisplayMode = .never
//
//        let search = UISearchController(searchResultsController: nil)
//        navigationItem.searchController = search
        
        let gradient = CAGradientLayer()
        var bounds = navigationBar.bounds
        bounds.size.height += view.window?.windowScene?.statusBarManager?.statusBarFrame.height ?? 0
        gradient.frame = bounds
        gradient.colors = [UIColor.red.cgColor, UIColor.init(red: 255/255, green: 20/255, blue: 147/255, alpha: 1.0).cgColor]
        gradient.startPoint = CGPoint(x: 0, y: 0)
        gradient.endPoint = CGPoint(x: 1, y: 1)
        if let image = getImageFrom(gradientLayer: gradient) {
//            navigationBar.setBackgroundImage(image, for: UIBarMetrics.default)
            navigationBar.barTintColor = UIColor(patternImage: image)
        }
        navigationBar.tintColor = .white
        navigationBar.titleTextAttributes = [
            NSAttributedString.Key.foregroundColor: UIColor.white,
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 20, weight: .bold)
        ]
    }
    
    func getImageFrom(gradientLayer: CAGradientLayer) -> UIImage? {
        var gradientImage:UIImage?
        UIGraphicsBeginImageContext(gradientLayer.frame.size)
        if let context = UIGraphicsGetCurrentContext() {
            gradientLayer.render(in: context)
            gradientImage = UIGraphicsGetImageFromCurrentImageContext()?.resizableImage(withCapInsets: UIEdgeInsets.zero, resizingMode: .stretch)
        }
        UIGraphicsEndImageContext()
        return gradientImage
    }
    
}
