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
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
            
            let presentableMovies = remoteResponse.results.map {
                PresentableMovie(
                    id: $0.id ?? 0,
                    title: $0.title ?? "no title",
                    overView: $0.overview ?? "no OverView",
                    image: URL(string: $0.posterPath ?? "") ?? URL(string: "https://default.url/image.png")!,
                    year: dateFormatter.date(from: $0.releaseDate ?? "") ?? Date(timeIntervalSince1970: 0)
                )
            }

            // Group and sort movies by date
            let groupedMovies = Dictionary(grouping: presentableMovies) { $0.year }
            let sortedFeed: [(Date, [PresentableMovie])] = groupedMovies
                .map { (key: Date, value: [PresentableMovie]) in (key, value) }
                .sorted { $0.0 > $1.0 }
            
            // Wrap sortedFeed in GroupedMovies and use it in PresentableFeed
            return PresentableFeed(
                isLastPage: remoteResponse.isLastPage,
                feed: GroupedMovies(groupedMovies: sortedFeed)
            )
        }
    }
}


