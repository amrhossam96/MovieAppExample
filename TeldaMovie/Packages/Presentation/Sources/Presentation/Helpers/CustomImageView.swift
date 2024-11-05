//
//  CustomImageView.swift
//  Presentation
//
//  Created by Amr on 05/11/2024.
//

import UIKit
import Combine

class CustomImageView: UIImageView {
    private var cancellables = Set<AnyCancellable>()

    func setImage(from urlString: String) {
        ImageLoader.shared.loadImage(from: urlString)
            .receive(on: DispatchQueue.main) // Update UI on main thread
            .sink { [weak self] image in
                self?.image = image
            }
            .store(in: &cancellables)
    }
}
