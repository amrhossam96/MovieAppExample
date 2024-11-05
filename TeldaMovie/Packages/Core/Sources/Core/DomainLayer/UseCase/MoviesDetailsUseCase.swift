//
//  File.swift
//  Core
//
//  Created by Amr on 05/11/2024.
//

import Foundation
import Combine

public protocol MovieDetailsUseCase {
    var loader: HomeMoviesLoaderProtocol { get }
    func retrieveMovieDetails(with id: Int) -> AnyPublisher<PresentableMovieDetails, Error>
    func retrieveSimilarMovies(for id: Int) -> AnyPublisher<[PresentableMovie], Error>
    func retrieveCast(for id: Int) -> AnyPublisher<[PresentableCastMember], Error>
}

extension MovieDetailsUseCase {
    public func retrieveMovieDetails(with id: Int) -> AnyPublisher<PresentableMovieDetails, Error> {
        loader.fetchMovieDetails(with: id)
            .mapToPresentableMovieDetail()
            .eraseToAnyPublisher()
    }
    
    public func retrieveSimilarMovies(for id: Int) -> AnyPublisher<[PresentableMovie], Error> {
        loader.fetchSimilarMovies(for: id)
            .mapToPresentableMovies()
            .eraseToAnyPublisher()
    }
    
    public func retrieveCast(for id: Int) -> AnyPublisher<[PresentableCastMember], Error> {
        loader.fetchCast(for: id)
            .mapToPresentableMovieCastMembers()
            .eraseToAnyPublisher()
    }
}

private extension Publisher where Output == CastBaseResponse, Failure == Error {
    func mapToPresentableMovieCastMembers() -> Publishers.Map<Self, [PresentableCastMember]> {
        self.map(\.cast).map { cast in
            cast.map {
                PresentableCastMember(
                    id: $0.id,
                    name: $0.name,
                    character: $0.character,
                    popularity: $0.popularity,
                    knownForDepartment: $0.knownForDepartment,
                    profilePath: "https://image.tmdb.org/t/p/w500"+($0.profilePath ?? "")
                )
            }
        }
    }
}

private extension Publisher where Output == SimilarBaseResponse, Failure == Error {
    func mapToPresentableMovies() -> Publishers.Map<Self, [PresentableMovie]> {
        self.map(\.results).map { remoteMovies in
            remoteMovies.map {
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "yyyy-MM-dd"
                let releaseDate = dateFormatter.date(from: $0.releaseDate ?? "") ?? Date(timeIntervalSince1970: 0)
                
                return PresentableMovie(
                    id: $0.id ?? 0,
                    title: $0.title ?? "no title",
                    overView: $0.overview ?? "no OverView",
                    image: URL(string: "https://image.tmdb.org/t/p/w500" + ($0.posterPath ?? ""))!,
                    year: releaseDate, // This is now a Date
                    voteAverage: $0.voteAverage ?? 0.0
                )
            }
        }
    }
}


private extension Publisher where Output == RemoteMovieDetailsResponse, Failure == Error {
    func mapToPresentableMovieDetail() -> Publishers.Map<Self, PresentableMovieDetails> {
        self.map {
            PresentableMovieDetails(
                id: $0.id,
                title: $0.title,
                overView: $0.overview,
                image: URL(string: "https://image.tmdb.org/t/p/w500"+($0.posterPath))!,
                tagline: $0.tagline,
                revenue: $0.revenue,
                releaseDate: $0.releaseDate,
                status: $0.status
            )
        }
    }
}
