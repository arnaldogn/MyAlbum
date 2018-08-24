//
//  AlbumService.swift
//  MyAlbum
//
//  Created by Arnaldo on 8/23/18.
//  Copyright © 2018 Arnaldo. All rights reserved.
//

import Swinject

public class DependencyManager {
    
    private lazy var container: Container = {
        let container = Container()
        container.register(APIManagerProtocol.self) { _ in APIManager() }.inObjectScope(.weak)
        container.register(FetchAlbumsServiceProtocol.self) { _ in FetchAlbumsService() }
        container.register(FetchPhotosServiceProtocol.self) { _ in FetchPhotosService() }
        container.register(AlbumsViewController.self) {
            return AlbumsViewController(service: $0.resolve(FetchAlbumsServiceProtocol.self)!)
        }
        container.register(PhotosViewController.self) {
            return PhotosViewController(service: $0.resolve(FetchPhotosServiceProtocol.self)!)
        }
        container.register(PhotoDetailViewController.self) { _ in
            return PhotoDetailViewController()
        }
        return container
    }()
    
    public static let shared = DependencyManager()
    
    public func bind<T>(interface: T.Type, to assembly: T) {
        container.register(interface) { _ in assembly }
    }
    
    public func resolve<T>(interface: T.Type) -> T! {
        return container.resolve(interface)
    }
    
    init() {}
}

public extension DependencyManager {
    
    static func bind<T>(interface: T.Type, to assembly: T) {
        DependencyManager.shared.bind(interface: interface, to: assembly)
    }
    
    static func resolve<T>(interface: T.Type) -> T! {
        return DependencyManager.shared.resolve(interface: interface)
    }
}

