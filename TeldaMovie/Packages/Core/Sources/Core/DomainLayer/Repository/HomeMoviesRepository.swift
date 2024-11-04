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
}

public final class HomeMoviesLoader: HomeMoviesLoaderProtocol {
    
    let remoteDataSource: MoviesLoaderAPI
    public init(remoteDataSource: MoviesLoaderAPI) {
        self.remoteDataSource = remoteDataSource
    }
    
    public func fetchMovies() -> AnyPublisher<RemoteBaseResponse, Error> {
        remoteDataSource.fetchMovies()
    }
}
