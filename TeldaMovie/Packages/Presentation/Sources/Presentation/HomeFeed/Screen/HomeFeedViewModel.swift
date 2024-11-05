//
//  HomeFeedViewModel.swift
//  Presentation
//
//  Created by Amr on 04/11/2024.
//

import Foundation
import protocol Core.HomeMoviesLoaderProtocol
import protocol Core.MoviesUseCase
import struct Core.PresentableFeed
import struct Core.PresentableMovie
import Combine

class HomeFeedViewModel: ObservableObject, MovieListUsesCases {
    var loader: HomeMoviesLoaderProtocol
    var coordinator: HomeFeedCoordinatorProtocol
    // MARK: - Private
    
    private var subscriptions: Set<AnyCancellable> = []
    
    // MARK: - Internal
    
    @Published var presentableFeed: PresentableFeed?
    @Published var searchedMovies: PresentableFeed?
    
    init(loader: HomeMoviesLoaderProtocol, coordinator: HomeFeedCoordinatorProtocol) {
        self.loader = loader
        self.coordinator = coordinator
    }
    
    func viewDidLoad() {
        retrieveGroupedMovies()
            .sink { completion in
                print(completion)
            } receiveValue: { [weak self] result in
                guard let self else { return }
                self.presentableFeed = result
            }
            .store(in: &subscriptions)
    }
    
    @MainActor func didSelectItem(at section: Int, row: Int) {
        guard let feed = presentableFeed?.feed
        else { return }
        let movie = feed.groupedMovies[section].1[row]
        coordinator.navigateToDetails(for: movie.id)
        print(movie.id)
        
    }
    
    func didTypeInSearchBar(text: String) {
        retrieveMovies(by: text)
            .sink { completion in
                print(completion)
            } receiveValue: { [weak self] result in
                guard let self = self else { return }
                if !result.feed.groupedMovies.isEmpty {
                    self.searchedMovies = result
                }
            }
            .store(in: &subscriptions)
    }
}
