//
//  HomeFeedCoordinator.swift
//  Presentation
//
//  Created by Amr on 05/11/2024.
//

import UIKit

@MainActor
protocol HomeFeedCoordinatorProtocol {
    func navigateToDetails(for id: Int)
}

class HomeFeedCoordinator: Coordinator {
    
    var rootView: UINavigationController = UINavigationController()

    func start() {
        let factory = HomeFeedModuleFactory(coordinator: self)
        let vc = factory.makeView()
        rootView.setViewControllers([vc], animated: false)
    }
}

extension HomeFeedCoordinator: HomeFeedCoordinatorProtocol {
    func navigateToDetails(for id: Int) {
        let detailsCoordinator = MovieDetailsCoordinator()
        detailsCoordinator.rootView = rootView
        detailsCoordinator.dataSource = MovieDetailsDataSource(movieID: id)
        detailsCoordinator.start()
    }
}
