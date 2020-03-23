//
//  DetailViewController.swift
//  MarvelMVVM
//
//  Created by Daniel Rocha on 1/22/20.
//  Copyright © 2020 Daniel Rocha. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var characterDescription: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var collectionHeight: NSLayoutConstraint!
    
    //MARK: - Private Properties
    private let viewModel: DetailViewModel?
    
    //MARK: - Initializers
    init(viewModel: DetailViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        self.viewModel = nil
        super.init(coder: coder)
    }
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Details"
        navigationItem.largeTitleDisplayMode = .never
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Close", style: .plain, target: self, action: #selector(close))
        
        setupView()
        registerCell()
        viewModel?.fetchCommics(success: { [weak self] in
            guard let self = self else { return }
            UIView.animate(withDuration: 0.0, animations: {
                self.collectionView.reloadData()
            }, completion: { (completion) in
                self.scrollViewDidScroll(self.scrollView)
            })
            
        })
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        viewModel?.finish()
    }
    
    //MARK: - Internal Methods
    func setupView() {
        image.kf.indicatorType = .activity
        image.kf.setImage(with: viewModel?.character.thumbnail?.getUrl())
        name.text = viewModel?.character.name
        characterDescription.text = viewModel?.character.description?.isEmpty == false ? viewModel?.character.description : "This character has no description"
        
        collectionHeight.constant = CommicCollectionCell.height + 1
    }
    
    func registerCell() {
        let nib = UINib(nibName: "CommicCollectionCell", bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: "CommicCollectionCell")
    }
    
    @objc
    func close() {
        self.dismiss(animated: true)
    }
}

extension DetailViewController: UICollectionViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let centerX = scrollView.contentOffset.x + scrollView.frame.size.width/2
        for cell in collectionView.visibleCells {

            var offsetX = centerX - cell.center.x
            if offsetX < 0 {
                offsetX *= -1
            }

            cell.transform = CGAffineTransform(scaleX: 1, y: 1)
            if offsetX > 50 {

                let offsetPercentage = (offsetX - 50) / view.bounds.width
                var scaleX = 1-offsetPercentage

                if scaleX < 0.8 {
                    scaleX = 0.8
                }
                cell.transform = CGAffineTransform(scaleX: scaleX, y: scaleX)
            }
        }
    }
}

extension DetailViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel?.commics.count ?? 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = (collectionView.dequeueReusableCell(withReuseIdentifier: "CommicCollectionCell", for: indexPath) as? CommicCollectionCell) else {
            return UICollectionViewCell()
        }
        
        cell.setup(commic: viewModel?.commics[indexPath.row])
        
        return cell
    }
}

extension DetailViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: CommicCollectionCell.width,
                      height: CommicCollectionCell.height)
    }
}
