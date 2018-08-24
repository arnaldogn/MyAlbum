//
//  photoCascadeManager.swift
//  MyAlbum
//
//  Created by Arnaldo on 8/23/18.
//  Copyright © 2018 Arnaldo. All rights reserved.
//

import UIKit
import ACProgressHUD_Swift

protocol PhotoCascadeManagerDelegate: class {
    func didSelect(_ photo: PhotoDataModel)
}

protocol PhotoCascadeManagerProtocol {
    var view: PhotoCascadeView { get }
    func loadPhotos(for album: Int)
    var delegate: PhotoCascadeManagerDelegate? { get set }
}

class PhotoCascadeManager: NSObject, PhotoCascadeManagerProtocol {
    private let service: FetchPhotosServiceProtocol
    internal let view = PhotoCascadeView(frame: .zero)
    fileprivate var photoList = [Photo]()
    weak var delegate: PhotoCascadeManagerDelegate?
    
    init(service: FetchPhotosServiceProtocol) {
        self.service = service
        super.init()
        view.collectionView.delegate = self
        view.collectionView.dataSource = self
        view.collectionView.register(PhotoCell.self, forCellWithReuseIdentifier: PhotoCell.defaultIdentifier)
    }
    
    internal func loadPhotos(for album: Int) {
        ACProgressHUD.shared.showHUD()
        service.fetch(for: album) { (response, error) in
            ACProgressHUD.shared.hideHUD()
            guard error == nil, let photos = response else {
                return
            }
            self.photoList = photos
            self.view.collectionView.reloadData()
        }
    }
}

extension PhotoCascadeManager: UICollectionViewDelegate, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photoList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotoCell.defaultIdentifier, for: indexPath) as? PhotoCell else {
            return UICollectionViewCell()
        }
        cell.configure(with: PhotoDataModel(photoList[indexPath.row]))
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.didSelect(PhotoDataModel(photoList[indexPath.row]))
    }
}
