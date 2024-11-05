//
//  MovieDetailsCoordinator.swift
//  Presentation
//
//  Created by Amr on 05/11/2024.
//

import UIKit

@MainActor
protocol MovieDetailsCoordinatorProtocol {
    func popBack()
}

class MovieDetailsCoordinator: Coordinator {
    var rootView: UINavigationController = UINavigationController()
    var dataSource: MovieDetailsDataSourceProtocol?
    func start() {
        let factory = MovieDetailsModuleFactory(coordinator: self)
        guard let dataSource else { return }
        let vc = factory.makeView(dataSource: dataSource)
        rootView.pushViewController(vc, animated: true)
    }
}

extension MovieDetailsCoordinator: MovieDetailsCoordinatorProtocol {
    func popBack() {
        rootView.popViewController(animated: true)
    }
}




