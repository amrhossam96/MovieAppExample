//
//  HomeFeedCoordinator.swift
//  Presentation
//
//  Created by Amr on 05/11/2024.
//

import UIKit

class HomeFeedCoordinator: Coordinator {
    
    var rootView: UINavigationController = UINavigationController()

    func start() {
        let factory = HomeFeedModuleFactory()
        let vc = factory.makeView()
        rootView.setViewControllers([vc], animated: false)
    }
}
