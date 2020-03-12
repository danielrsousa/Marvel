//
//  DetailViewController.swift
//  MarvelMVVM
//
//  Created by Daniel Rocha on 1/22/20.
//  Copyright © 2020 Daniel Rocha. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

//    @IBOutlet weak var imageTeste: UIImageView!
//    let imageTeste = UIImageView(image: UIImage(named: "teste"))
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var characterDescription: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var fixedButton: UIPrimaryButton!
    @IBOutlet weak var floatButton: UIPrimaryButton!
    
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
        
        setupView()
        registerCell()
        viewModel?.fetchCommics(success: { [weak self] in
            self?.collectionView.reloadData()
        })
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        viewModel?.finish()
    }
    
    //MARK: - Internal Methods
    func setupView() {
        image.kf.setImage(with: viewModel?.character.thumbnail?.getUrl())
        name.text = viewModel?.character.name
        characterDescription.text = viewModel?.character.description?.isEmpty == false ? viewModel?.character.description : "Este personagem não possui descrição"
    }
    
    func registerCell() {
        let nib = UINib(nibName: "CommicCollectionCell", bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: "CommicCollectionCell")
    }
    
//    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        let centerX = scrollView.contentOffset.x + scrollView.frame.size.width/2
//        for cell in collectionView.visibleCells {
//
//            var offsetX = centerX - cell.center.x
//            if offsetX < 0 {
//                offsetX *= -1
//            }
//
//            cell.transform = CGAffineTransform(scaleX: 1, y: 1)
//            if offsetX > 50 {
//
//                let offsetPercentage = (offsetX - 50) / view.bounds.width
//                var scaleX = 1-offsetPercentage
//
//                if scaleX < 0.8 {
//                    scaleX = 0.8
//                }
//                cell.transform = CGAffineTransform(scaleX: scaleX, y: scaleX)
//            }
//        }
//    }
}

extension DetailViewController: UIScrollViewDelegate {

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.bounds.contains(floatButton.frame) {
            UIView.animate(withDuration: 0.2) {
                self.fixedButton.alpha = 1.0
                self.floatButton.alpha = 0.0
            }
        } else {
            UIView.animate(withDuration: 0.2) {
                self.fixedButton.alpha = 0.0
                self.floatButton.alpha = 1.0
            }
        }
    }

}


extension DetailViewController: UICollectionViewDelegate {
    
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
        let width = (UIScreen.main.bounds.width / 2)
        return CGSize(width: width, height: width * 1.3)
    }

//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
//        let width = collectionView.frame.width
//        let margin = width * 0.3
//        return UIEdgeInsets(top: 10, left: margin / 2, bottom: 10, right: margin / 2)
//    }

}
