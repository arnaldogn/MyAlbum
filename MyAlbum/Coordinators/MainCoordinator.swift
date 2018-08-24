//
//  MainCoordinator.swift
//  MyAlbum
//
//  Created by Arnaldo on 8/23/18.
//  Copyright © 2018 Arnaldo. All rights reserved.
//

import UIKit

class MainCoordinator: Coordinator {
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
      showDashboard()
    }
    
    func showDashboard() {
        guard let albumVC = DependencyManager.resolve(interface: AlbumsViewController.self) else { return }
        albumVC.delegate = self
        navigationController.pushViewController(albumVC, animated: true)
    }
}

extension MainCoordinator: AlbumsViewControllerDelegate {
    func showDetails(for album: AlbumDataModel) {
        guard let photosVC = DependencyManager.resolve(interface: PhotosViewController.self) else { return }
        photosVC.groupId = album.id
        photosVC.delegate = self
        navigationController.pushViewController(photosVC, animated: true)
    }
}

extension MainCoordinator: PhotosViewControllerDelegate {
    func showDetail(for photo: PhotoDataModel) {
        guard let photoDetailVC = DependencyManager.resolve(interface: PhotoDetailViewController.self) else { return }
        photoDetailVC.photo = photo
        photoDetailVC.modalPresentationStyle = .overCurrentContext
        photoDetailVC.delegate = self
        navigationController.present(photoDetailVC, animated: true, completion: nil)
    }
}

extension MainCoordinator: PhotoDetailViewControllerDelegate {
    func photoDetailDidFinish() {
        navigationController.dismiss(animated: true, completion: nil)
    }
}
