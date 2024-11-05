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
        request(HomeFeedService.homeFeed)
    }
    
    public func fetchMovieDetails(with id: Int) -> AnyPublisher<RemoteMovieDetailsResponse, any Error> {
        request(HomeFeedService.movieDetails(id))
    }
    
    public func fetchSimilarMovies(for id: Int) -> AnyPublisher<SimilarBaseResponse, any Error> {
        request(HomeFeedService.similarMovies(id))
    }
    
    public func fetchCast(for id: Int) -> AnyPublisher<CastBaseResponse, any Error> {
        request(HomeFeedService.cast(id))
    }
    
    public func fetchMoviesBy(query: String) -> AnyPublisher<RemoteBaseResponse, any Error> {
        request(HomeFeedService.search(query))
    }
}
