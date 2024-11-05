//
//  MoviesUseCase.swift
//  Core
//
//  Created by Amr on 04/11/2024.
//

import Foundation
import Combine

public protocol MoviesUseCase {
    var loader: HomeMoviesLoaderProtocol { get }
    func retrieveGroupedMovies() -> AnyPublisher<PresentableFeed, Error>
    
}

extension MoviesUseCase {
    public func retrieveGroupedMovies() -> AnyPublisher<PresentableFeed, Error> {
        loader
            .fetchMovies()
            .mapToPresentableMovies()
            .eraseToAnyPublisher()
    }
    
    
}

private extension Publisher where Output == RemoteBaseResponse, Failure == Error {
    func mapToPresentableMovies() -> Publishers.Map<Self, PresentableFeed> {
        self.map { remoteResponse in
            let presentableMovies = remoteResponse.results.map {
                PresentableMovie(
                    id: $0.id ?? 0,
                    title: $0.title ?? "no title",
                    overView: $0.overview ?? "no OverView",
                    image: URL(string: $0.posterPath ?? "") ?? URL(string: "https://default.url/image.png")!,
                    year: $0.releaseDate ?? "no date"
                )
            }
            
            
            let groupedMovies = Dictionary(
                grouping: presentableMovies,
                by: MoviesGroupingPolicy.groupingPolicy
            )
            
            let groupedMoviesStruct = GroupedMovies(groupedMovies: groupedMovies)
            
            return PresentableFeed(
                isLastPage: remoteResponse.isLastPage,
                feed: groupedMoviesStruct
            )
        }
    }
}

