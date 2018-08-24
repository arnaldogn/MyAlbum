//
//  AlbumService.swift
//  MyAlbum
//
//  Created by Arnaldo on 8/23/18.
//  Copyright © 2018 Arnaldo. All rights reserved.
//

import Alamofire

typealias FetchAlbumsCompletionBlock = (_ result: [Album]?, _ error: CustomError?) -> ()

protocol FetchAlbumsServiceProtocol {
    func fetch(_ completion: @escaping FetchAlbumsCompletionBlock)
}

struct FetchAlbumsService: FetchAlbumsServiceProtocol {
    internal func fetch(_ completion: @escaping FetchAlbumsCompletionBlock){
        return DependencyManager.resolve(interface: APIManagerProtocol.self).request(url: Constants.Url.albums, completion: completion)
    }
}
