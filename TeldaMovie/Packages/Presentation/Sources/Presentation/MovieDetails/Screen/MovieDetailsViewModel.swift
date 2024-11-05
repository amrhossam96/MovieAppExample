//
//  MovieDetailsViewModel.swift
//  Presentation
//
//  Created by Amr on 05/11/2024.
//

import Foundation
import Combine
import protocol Core.MoviesUseCase
import protocol Core.HomeMoviesLoaderProtocol
import struct Core.PresentableMovieDetails
import struct Core.PresentableMovie
import struct Core.PresentableCastMember

protocol MovieDetailsViewModelDependenciesProtocol {
    var dataSource: MovieDetailsDataSourceProtocol { get }
    
}

class MovieDetailsViewModel: ObservableObject, MoveDetailsUseCase {
    
    var loader: any HomeMoviesLoaderProtocol
    private var subscriptions: Set<AnyCancellable> = []

    private let dependencies: MovieDetailsViewModelDependenciesProtocol
    @Published var presentableMovieDetails: PresentableMovieDetails?
    @Published var similarMovies: [PresentableMovie] = []
    @Published var similarMovieActors: [PresentableCastMember] = []
    @Published var similarMovieDirectors: [PresentableCastMember] = []
    @Published var selectedSimilarMovie: PresentableMovie?
    
    init(loader: HomeMoviesLoaderProtocol, dependencies: MovieDetailsViewModelDependenciesProtocol) {
        self.dependencies = dependencies
        self.loader = loader
    }
    
    func viewDidLoad() {
        retrieveMovieDetails(with: dependencies.dataSource.movieID)
            .sink { completion in
                print(completion)
            } receiveValue: { [weak self] result in
                guard let self else { return }
                presentableMovieDetails = result
            }
            .store(in: &subscriptions)
        
        retrieveSimilarMovies(for: dependencies.dataSource.movieID)
            .sink {  completion in
                print(completion)
            } receiveValue: { [weak self] result in
                guard let self else { return }
                similarMovies = result
                if selectedSimilarMovie == nil {
                    selectedSimilarMovie = similarMovies.first
                    didSelectSimilarMovie(with: selectedSimilarMovie!)
                }
            }
            .store(in: &subscriptions)
    }
    
    func didSelectSimilarMovie(with movie: PresentableMovie) {
        selectedSimilarMovie = movie
        retrieveCast(for: movie.id)
            .sink { completion in
                print(completion)
            } receiveValue: { [weak self] castMembers in
                guard let self else { return }
                similarMovieActors = castMembers
                    .filter { $0.knownForDepartment == "Acting" }
                    .sorted(by: { $0.popularity > $1.popularity })
                similarMovieDirectors = castMembers
                    .filter { $0.knownForDepartment == "Directing" }
                    .sorted(by: { $0.popularity > $1.popularity })
                print("[AMR] \(similarMovieDirectors)")
            }
            .store(in: &subscriptions)
    }
}
