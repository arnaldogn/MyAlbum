//
//  PhotoDataModel.swift
//  MyAlbum
//
//  Created by Arnaldo on 8/23/18.
//  Copyright © 2018 Arnaldo. All rights reserved.
//

import Foundation

class PhotoDataModel: NSObject {
    private let photo: Photo
    
    init(_ photo: Photo) {
        self.photo = photo
        super.init()
    }
    
    var id: Int {
        return photo.id
    }
    var title: String {
        return photo.title
    }
    var thumbnail: URL? {
        return URL(string: photo.thumbnailUrl)
    }
    var url: URL? {
        return URL(string: photo.url)
    }
}
