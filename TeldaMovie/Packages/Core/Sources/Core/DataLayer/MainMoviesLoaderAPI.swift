//
//  MainMoviesLoaderAPI.swift
//  Core
//
//  Created by Amr on 04/11/2024.
//

import Foundation
import Combine

public class MainMoviesLoaderAPI: MoviesLoaderAPI {
    
    public init() {}
    
    public func fetchMovies() -> AnyPublisher<RemoteBaseResponse, any Error> {
        let request: AnyPublisher<RemoteBaseResponse, Error> = request(HomeFeedService.homeFeed)
        return request.eraseToAnyPublisher()
    }
}
