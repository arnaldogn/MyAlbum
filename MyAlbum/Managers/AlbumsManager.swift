//
//  AlbumsManager.swift
//  MyAlbum
//
//  Created by Arnaldo on 8/23/18.
//  Copyright © 2018 Arnaldo. All rights reserved.
//

import UIKit
import ACProgressHUD_Swift

protocol AlbumsManagerDelegate {
    func didSelect(album: AlbumDataModel)
    func didFinishLoad(with error: CustomError?)
}

protocol AlbumsManagerProtocol {
    var tableView: UITableView { get }
    var delegate: AlbumsManagerDelegate? { get set }
    func loadAlbums()
}

class AlbumsManager: NSObject, AlbumsManagerProtocol {
    internal var tableView = UITableView()
    internal var delegate: AlbumsManagerDelegate?
    private var albums = [Album]()
    private var service: FetchAlbumsServiceProtocol?
    
    init(service: FetchAlbumsServiceProtocol) {
        self.service = service
    }
    
    internal func loadAlbums() {
        ACProgressHUD.shared.showHUD()
        service?.fetch({ (result, error) in
            ACProgressHUD.shared.hideHUD()
            guard let result = result
                else {
                    self.delegate?.didFinishLoad(with: error)
                    return
            }
            self.albums = result
            self.tableView.dataSource = self
            self.tableView.delegate = self
            self.tableView.reloadData()
        })
    }
}

extension AlbumsManager: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "Cell")
        if cell == nil {
            cell = UITableViewCell(style: .default, reuseIdentifier: "Cell")
        }
        let album = AlbumDataModel(albums[indexPath.row])
        cell?.textLabel?.text = album.title
        cell?.selectionStyle = .none
        return cell ?? UITableViewCell()
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return albums.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.didSelect(album: AlbumDataModel(albums[indexPath.row]))
    }
}
