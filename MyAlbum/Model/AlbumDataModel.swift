//
//  AlbumDataModel.swift
//  MyAlbum
//
//  Created by Arnaldo on 8/23/18.
//  Copyright © 2018 Arnaldo. All rights reserved.
//

import Foundation

class AlbumDataModel: NSObject {
    private let album: Album
    
    init(_ album: Album) {
        self.album = album
        super.init()
    }
    var id: Int {
        return album.id
    }
    var title: String {
        return album.title
    }
}

