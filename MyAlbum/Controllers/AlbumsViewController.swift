//
//  ViewController.swift
//  MyAlbum
//
//  Created by Arnaldo on 8/23/18.
//  Copyright © 2018 Arnaldo. All rights reserved.
//

import UIKit

protocol AlbumsViewControllerDelegate: class {
    func showDetails(for album: AlbumDataModel)
}

class AlbumsViewController: UIViewController {
    var albumsService: FetchAlbumsServiceProtocol
    private var manager: AlbumsManagerProtocol
    weak var delegate: AlbumsViewControllerDelegate?
    
    init(service: FetchAlbumsServiceProtocol) {
        self.albumsService = service
        manager = AlbumsManager(service: albumsService)
        super.init(nibName: nil, bundle: nil)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Albums"
        manager.loadAlbums()
    }

    private func setupViews() {
        manager.delegate = self
        manager.tableView.tableFooterView = UIView()
        edgesForExtendedLayout = []
        view.backgroundColor = .white
        view.addSubviewsForAutolayout(manager.tableView)
        setupConstraints()
    }
    
    func setupConstraints() {
        let views = ["tableView": manager.tableView]
        view.addConstraints(
            NSLayoutConstraint.constraints("H:|[tableView]|", views: views),
            NSLayoutConstraint.constraints("V:|[tableView]|", views: views))
    }
}

extension AlbumsViewController: AlbumsManagerDelegate {
    func didSelect(album: AlbumDataModel) {
        delegate?.showDetails(for: album)
    }
    
    func didFinishLoad(with error: CustomError?) {
        showMessage(error?.message)
    }
}

