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
    
    // MARK: - Private
    
    private var subscriptions: Set<AnyCancellable> = []
    
    // MARK: - Internal
    
    @Published var presentableFeed: PresentableFeed?
    
    init(loader: HomeMoviesLoaderProtocol) {
        self.loader = loader
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
    
//    func movies(for year: Date) -> [PresentableMovie] {
//        return presentableFeed?.feed.groupedMovies[year] ?? []
//    }
}
