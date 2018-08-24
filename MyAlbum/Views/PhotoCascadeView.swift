//
//  PhotoCascadeView.swift
//  MyAlbum
//
//  Created by Arnaldo on 8/23/18.
//  Copyright © 2018 Arnaldo. All rights reserved.
//

import UIKit

class PhotoCascadeView: UIView {
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        let width = UIScreen.main.bounds.width
        let itemWidth = width/CGFloat(Constants.numberOfItemsPerLine)
        layout.itemSize = CGSize(width: itemWidth, height: itemWidth)
        layout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        return collectionView
    }()
    enum Constants {
        static let headerIdentifier = "PhotosCascadeHeader"
        static let numberOfItemsPerLine = 2
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        clipsToBounds = true
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        addSubviewsForAutolayout(collectionView)
        setupConstraints()
    }
    
    func setupConstraints() {
        let views = ["collectionView": collectionView]
        addConstraints(
            NSLayoutConstraint.constraints("H:|[collectionView]|", views: views),
            NSLayoutConstraint.constraints("V:|[collectionView]|", views: views))
    }
}
