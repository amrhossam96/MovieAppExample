//
//  HomeFeedModuleFactory.swift
//  Presentation
//
//  Created by Amr on 05/11/2024.
//

import UIKit

@MainActor
public protocol HomeFeedModuleFactoryProtocol {
    func makeView() -> UIViewController
}
