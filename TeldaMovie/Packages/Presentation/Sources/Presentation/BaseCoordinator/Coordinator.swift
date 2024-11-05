//
//  Coordinator.swift
//  Presentation
//
//  Created by Amr on 04/11/2024.
//

import UIKit
import Combine

@MainActor
public protocol Coordinator {
    var rootView: UINavigationController { get }
    func start()
}



public class ApplicationCoordinator: Coordinator {
    public var rootView: UINavigationController = UINavigationController()
    
    
    // MARK: - Properties
    
    private let window: UIWindow
    private var subscriptions: Set<AnyCancellable> = []
    
    // MARK: - Lifecycle
    
    public init(window: UIWindow) {
        self.window = window
    }
}

// MARK: - Coordinator

extension ApplicationCoordinator {
    
    public func start() {
        let homeCoordinator = HomeFeedCoordinator()
        homeCoordinator.rootView = rootView
        homeCoordinator.start()

        window.rootViewController = rootView
        window.makeKeyAndVisible()
    }
}
