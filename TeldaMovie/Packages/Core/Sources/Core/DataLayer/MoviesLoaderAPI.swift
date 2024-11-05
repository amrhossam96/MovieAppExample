//
//  MoviesLoaderAPI.swift
//  Core
//
//  Created by Amr on 04/11/2024.
//

import Foundation
import protocol Networking.NetworkService
import Combine

public protocol MoviesLoaderAPI: NetworkService {
    func fetchMovies() -> AnyPublisher<RemoteBaseResponse, Error>
    func fetchMovieDetails(with id: Int) -> AnyPublisher<RemoteMovieDetailsResponse, Error>
    func fetchSimilarMovies(for id: Int) -> AnyPublisher<SimilarBaseResponse, Error>
    func fetchCast(for id: Int) -> AnyPublisher<CastBaseResponse, Error>
    func fetchMoviesBy(query: String) -> AnyPublisher<RemoteBaseResponse, Error>
}
