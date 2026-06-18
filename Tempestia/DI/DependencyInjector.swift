//
//  DependencyInjector.swift
//  Tempestia
//
//  Created by Thaowpsta Saiid on 15/06/2026.
//


import Swinject

class DependencyInjector {
    static let shared = DependencyInjector()
    let container = Container()
    
    private init() {
        container.register(LocationTrackerProtocol.self) { _ in
            LocationTracker()
        }.inObjectScope(.container)
        
        container.register(WeatherRepositoryProtocol.self) { _ in
            WeatherRepository()
        }.inObjectScope(.container)
        
        container.register(HomeViewModel.self) { resolver in
            let repository = resolver.resolve(WeatherRepositoryProtocol.self)!
            let locationTracker = resolver.resolve(LocationTrackerProtocol.self)!
            
            return HomeViewModel(repository: repository, locationTracker: locationTracker)
        }
        
        container.register(FavoriteViewModel.self) { resolver in
            let repository = resolver.resolve(WeatherRepositoryProtocol.self)!
            return FavoriteViewModel(repository: repository)
        }
    }
    
    static func resolve<T>(_ type: T.Type) -> T {
        return shared.container.resolve(T.self)!
    }
}
