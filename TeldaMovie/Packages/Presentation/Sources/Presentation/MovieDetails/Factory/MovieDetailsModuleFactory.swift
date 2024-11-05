//
//  File.swift
//  Presentation
//
//  Created by Amr on 05/11/2024.
//

import UIKit
import class Core.MainMoviesLoaderAPI
import class Core.HomeMoviesLoader


protocol MovieDetailsModuleFactoryProtocol {
    func makeView() -> UIViewController
}

struct MovieDetailsModuleFactory {
    let coordinator: MovieDetailsCoordinatorProtocol
    
    @MainActor
    func makeView(dataSource: any MovieDetailsDataSourceProtocol) -> UIViewController {
        let viewModel = MovieDetailsViewModel(loader: HomeMoviesLoader(remoteDataSource: MainMoviesLoaderAPI()),
                                              dependencies: MovieDetailsViewModelDependencies(dataSource: dataSource))
        let vc = MovieDetailsViewController(viewModel: viewModel)
        return vc
    }
}

// MARK: - MovieDetailsViewModelDependenciesProtocol

private struct MovieDetailsViewModelDependencies: MovieDetailsViewModelDependenciesProtocol {
    var dataSource: any MovieDetailsDataSourceProtocol
}
