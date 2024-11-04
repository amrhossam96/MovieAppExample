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
}
