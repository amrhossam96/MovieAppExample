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
    func retrieveMovies(by query: String) -> AnyPublisher<PresentableFeed, Error>
}

extension MoviesUseCase {
    public func retrieveGroupedMovies() -> AnyPublisher<PresentableFeed, Error> {
        loader
            .fetchMovies()
            .mapToPresentableMovies()
            .eraseToAnyPublisher()
    }
    
    public func retrieveMovies(by query: String) -> AnyPublisher<PresentableFeed, Error> {
        loader
            .fetchMovies(by: query)
            .mapToPresentableMovies()
            .eraseToAnyPublisher()
    }
}

private extension Publisher where Output == RemoteBaseResponse, Failure == Error {
    func mapToPresentableMovies() -> Publishers.Map<Self, PresentableFeed> {
        map { remoteResponse in
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"

            let presentableMovies = remoteResponse.results.map {
                let releaseDate = dateFormatter.date(from: $0.releaseDate ?? "") ?? Date(timeIntervalSince1970: 0)
                return PresentableMovie(
                    id: $0.id ?? 0,
                    title: $0.title ?? "no title",
                    overView: $0.overview ?? "no OverView",
                    image: URL(string: "https://image.tmdb.org/t/p/w500" + ($0.posterPath ?? $0.backdropPath ?? ""))!,
                    year: releaseDate,
                    voteAverage: $0.voteAverage ?? 0
                )
            }

            let groupedMovies = Dictionary(grouping: presentableMovies, by: MoviesGroupingPolicy.groupingPolicy)

            let sortedFeed: [(Date, [PresentableMovie])] = groupedMovies
                .map { (key: Date, value: [PresentableMovie]) in (key, value) }
                .sorted { $0.0 > $1.0 }

            return PresentableFeed(
                isLastPage: remoteResponse.isLastPage,
                feed: GroupedMovies(groupedMovies: sortedFeed)
            )
        }
    }
}
