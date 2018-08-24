//
//  FetchPhotosService.swift
//  MyAlbum
//
//  Created by Arnaldo on 8/23/18.
//  Copyright © 2018 Arnaldo. All rights reserved.
//

import Alamofire

typealias FetchPhotosCompletionBlock = (_ result: [Photo]?, _ error: CustomError?) -> ()

protocol FetchPhotosServiceProtocol {
    func fetch(for albumId: Int, completion: @escaping FetchPhotosCompletionBlock)
}

struct FetchPhotosService: FetchPhotosServiceProtocol {
    internal func fetch(for albumId: Int, completion: @escaping FetchPhotosCompletionBlock) {
        guard var query = URLComponents(string: Constants.Url.photos) else { return }
        query.queryItems = [URLQueryItem(name: "albumId", value: String(albumId))]
        guard let url = query.url else { return }
        return DependencyManager.resolve(interface: APIManagerProtocol.self).request(url: url.absoluteString, completion: completion)
    }
}
