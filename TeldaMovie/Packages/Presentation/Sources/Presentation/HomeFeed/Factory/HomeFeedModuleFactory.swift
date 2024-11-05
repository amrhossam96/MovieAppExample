//
//  HomeFeedModuleFactory.swift
//  Presentation
//
//  Created by Amr on 05/11/2024.
//

import UIKit
import protocol Core.MoviesUseCase
import class Core.HomeMoviesLoader
import class Core.MainMoviesLoaderAPI

struct HomeFeedModuleFactory {
    
}

extension HomeFeedModuleFactory: @preconcurrency HomeFeedModuleFactoryProtocol {
    @MainActor func makeView() -> UIViewController {
        let viewModel = HomeFeedViewModel(loader: HomeMoviesLoader(remoteDataSource: MainMoviesLoaderAPI()))
        let vc = HomeFeedViewController(viewModel: viewModel)
        return vc
    }
}
