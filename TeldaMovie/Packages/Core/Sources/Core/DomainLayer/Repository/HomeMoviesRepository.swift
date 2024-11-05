//
//  HomeMoviesRepository.swift
//  Core
//
//  Created by Amr on 04/11/2024.
//

import Foundation
import Combine

public protocol HomeMoviesLoaderProtocol {
    func fetchMovies() -> AnyPublisher<RemoteBaseResponse, Error>
    func fetchMovieDetails(with id: Int) -> AnyPublisher<RemoteMovieDetailsResponse, Error>
    func fetchSimilarMovies(for id: Int) -> AnyPublisher<SimilarBaseResponse, Error>
    func fetchCast(for id: Int) -> AnyPublisher<CastBaseResponse, Error>
    func fetchMovies(by query: String) -> AnyPublisher<RemoteBaseResponse, Error>
}

public final class HomeMoviesLoader: HomeMoviesLoaderProtocol {
    
    let remoteDataSource: MoviesLoaderAPI
    public init(remoteDataSource: MoviesLoaderAPI) {
        self.remoteDataSource = remoteDataSource
    }
    
    public func fetchMovies() -> AnyPublisher<RemoteBaseResponse, Error> {
        remoteDataSource.fetchMovies()
    }
    
    public func fetchMovieDetails(with id: Int) -> AnyPublisher<RemoteMovieDetailsResponse, any Error> {
        remoteDataSource.fetchMovieDetails(with: id)
    }
    
    public func fetchSimilarMovies(for id: Int) -> AnyPublisher<SimilarBaseResponse, Error> {
           remoteDataSource.fetchSimilarMovies(for: id)
    }
    
    public func fetchCast(for id: Int) -> AnyPublisher<CastBaseResponse, any Error> {
        remoteDataSource.fetchCast(for: id)
    }
    
    public func fetchMovies(by query: String) -> AnyPublisher<RemoteBaseResponse, any Error> {
        remoteDataSource.fetchMoviesBy(query: query)
    }
}
