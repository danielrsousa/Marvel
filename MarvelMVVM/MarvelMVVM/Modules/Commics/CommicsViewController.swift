//
//  CommicsViewController.swift
//  MarvelMVVM
//
//  Created by Daniel Rocha on 10/03/20.
//  Copyright © 2020 Daniel Rocha. All rights reserved.
//

import UIKit

class CommicsViewController: UIViewController {

    //MARK: - IBOutlets Properties
    @IBOutlet weak var collectionView: UICollectionView!
    
    //MARK: - Private Properties
    private let viewModel: CommicsViewModel?
    
    //MARK: - Initializers
    init(viewModel: CommicsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        self.viewModel = nil
        super.init(coder: coder)
    }
    
    //MARK: - Life Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Quadrinhos"
        registerCell()
        viewModel?.fetchCommics(success: { [weak self] in
            self?.collectionView.reloadData()
        })
    }
    
    func registerCell() {
        let layout = SnappingCollectionViewLayout()
        layout.scrollDirection = .horizontal
        collectionView.collectionViewLayout = layout
        collectionView?.decelerationRate = UIScrollView.DecelerationRate.fast
        
        let nib = UINib(nibName: "CommicCollectionCell", bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: "CommicCollectionCell")
    }
    
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

extension CommicsViewController: UICollectionViewDelegate {
    
}

extension CommicsViewController: UICollectionViewDataSource {
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

extension CommicsViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (UIScreen.main.bounds.width / 2)
        return CGSize(width: width, height: width * 1.3)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        let width = collectionView.frame.width
        let margin = width * 0.3
        return UIEdgeInsets(top: 10, left: margin / 2, bottom: 10, right: margin / 2)
    }
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
//        let width = (UIScreen.main.bounds.width / 2)
//        if let layout = collectionViewLayout as? SnappingCollectionViewLayout {
//            let n = Double(viewModel?.commics.count ?? 0)
//
//            return layout.centerItemsInCollectionView(cellWidth: Double(width), numberOfItems: n, spaceBetweenCell: 0.0, collectionView: collectionView)
//        }
//
//        return UIEdgeInsets()
//    }

    

    
    class SnappingCollectionViewLayout: UICollectionViewFlowLayout {
        
//        func centerItemsInCollectionView(cellWidth: Double, numberOfItems: Double, spaceBetweenCell: Double, collectionView: UICollectionView) -> UIEdgeInsets {
//            let totalWidth = cellWidth * numberOfItems
//            let totalSpacingWidth = spaceBetweenCell * (numberOfItems - 1)
//            let leftInset = (collectionView.frame.width - CGFloat(totalWidth + totalSpacingWidth)) / 2
//            let rightInset = leftInset
//            return UIEdgeInsets(top: 0, left: leftInset, bottom: 0, right: rightInset)
//        }
        
//        override func targetContentOffset(forProposedContentOffset proposedContentOffset: CGPoint, withScrollingVelocity velocity: CGPoint) -> CGPoint {
//            guard let collectionView = collectionView else { return super.targetContentOffset(forProposedContentOffset: proposedContentOffset, withScrollingVelocity: velocity) }
//
//            var offsetAdjustment = CGFloat.greatestFiniteMagnitude
//            let horizontalOffset = proposedContentOffset.x + collectionView.contentInset.left
//
//            let targetRect = CGRect(x: proposedContentOffset.x, y: 0, width: collectionView.bounds.size.width, height: collectionView.bounds.size.height)
//
//            let layoutAttributesArray = super.layoutAttributesForElements(in: targetRect)
//
//            layoutAttributesArray?.forEach({ (layoutAttributes) in
//                let itemOffset = layoutAttributes.frame.origin.x
//                if fabsf(Float(itemOffset - horizontalOffset)) < fabsf(Float(offsetAdjustment)) {
//                    offsetAdjustment = itemOffset - horizontalOffset
//                }
//            })
//
//            return CGPoint(x: proposedContentOffset.x + offsetAdjustment, y: proposedContentOffset.y)
//        }
    }
}
