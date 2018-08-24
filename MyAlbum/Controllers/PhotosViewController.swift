//
//  PhotosViewController.swift
//  MyAlbum
//
//  Created by Arnaldo on 8/23/18.
//  Copyright © 2018 Arnaldo. All rights reserved.
//

import UIKit

protocol PhotosViewControllerDelegate: class {
    func showDetail(for photo: PhotoDataModel)
}

class PhotosViewController: UIViewController {
    private var photosService: FetchPhotosServiceProtocol
    private var manager: PhotoCascadeManagerProtocol
    weak var delegate: PhotosViewControllerDelegate?
    var groupId: Int? {
        didSet {
            guard let group = groupId else { return }
            manager.loadPhotos(for: group)
        }
    }
    
    init(service: FetchPhotosServiceProtocol) {
        self.photosService = service
        manager = PhotoCascadeManager(service: photosService)
        super.init(nibName: nil, bundle: nil)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        title = "Photos".localized
        edgesForExtendedLayout = []
        view.backgroundColor = .lightGray
        manager.delegate = self
        view.addSubviewsForAutolayout(manager.view)
        setupConstraints()
    }
    
    private func setupConstraints() {
        let views = ["cascade": manager.view]
        view.addConstraints(
            NSLayoutConstraint.constraints("H:|[cascade]|", views: views),
            NSLayoutConstraint.constraints("V:|[cascade]|", views: views))
    }
}

extension PhotosViewController: PhotoCascadeManagerDelegate {
    func didSelect(_ photo: PhotoDataModel) {
        delegate?.showDetail(for: photo)
    }
}
