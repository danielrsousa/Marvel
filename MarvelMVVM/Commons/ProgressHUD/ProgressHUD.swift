//
//  ProgressHUD.swift
//  MarvelMVVM
//
//  Created by Daniel Rocha on 3/17/20.
//  Copyright © 2020 Daniel Rocha. All rights reserved.
//

import UIKit

class ProgressHUD: UIView {
    
    //MARK: - Enums
    enum HUDStyle {
        case black
        case white
        case custom(backgoundColor: UIColor)
    }
    
    //MARK: - Properties
    private static let shared = ProgressHUD()
    
    private var progessIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .large)
        indicator.translatesAutoresizingMaskIntoConstraints = false
        indicator.startAnimating()
        return indicator
    }()
    
    //MARK: - Initializers
    private init() {
        super.init(frame: .zero)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    //MARK: - Private methods
    private func setupView(){
        self.backgroundColor = UIColor.blue.withAlphaComponent(0.5)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(progessIndicator)
    }
    
    private func createConstraints() {
        guard let container = superview else { return }
        
        // ProgressHUD constraints
        NSLayoutConstraint.activate([
            leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 0.0),
            trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: 0.0),
            topAnchor.constraint(equalTo: container.topAnchor, constant: 0.0),
            bottomAnchor.constraint(equalTo: container.bottomAnchor, constant: 0.0)
        ])
        
        // Progress indicator constraints
        NSLayoutConstraint.activate([
            progessIndicator.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            progessIndicator.centerXAnchor.constraint(equalTo: self.centerXAnchor)
        ])
    }
    
    private func defineStyle(_ style: HUDStyle) {
        switch style {
        case .black:
            self.backgroundColor = UIColor.black.withAlphaComponent(0.4)
        case .white:
            self.backgroundColor = UIColor.white.withAlphaComponent(0.4)
        case .custom(let backgoundColor):
            self.backgroundColor = backgoundColor
        }
    }
    
    //MARK: - Public static methods
    public static func show(_ container: UIView? = nil, style: HUDStyle = .black) {
        let hud = ProgressHUD.shared
        guard let container = container else {
            return
        }
        
        if container is UITableView || container is UICollectionView {
            container.superview?.addSubview(hud)
        } else {
            container.addSubview(hud)
        }

        hud.defineStyle(style)
        hud.createConstraints()
        
        container.bringSubviewToFront(hud)
    }
    
    public static func dismiss() {
        let hud = ProgressHUD.shared
        hud.progessIndicator.startAnimating()
        hud.removeFromSuperview()
    }
    
}
