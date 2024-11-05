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

struct HomeFeedModuleFactory: HomeFeedModuleFactoryProtocol {
    let coordinator: HomeFeedCoordinatorProtocol
    func makeView() -> UIViewController {
        let viewModel = HomeFeedViewModel(
            loader: HomeMoviesLoader(remoteDataSource: MainMoviesLoaderAPI()),
            coordinator: coordinator
        )
        let vc = HomeFeedViewController(viewModel: viewModel)
        return vc
    }
}
