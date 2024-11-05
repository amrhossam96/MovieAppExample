//
//  ImageLoader.swift
//  Presentation
//
//  Created by Amr on 05/11/2024.
//

import UIKit
import Combine

class ImageLoader {
    @MainActor static let shared = ImageLoader()
    private var imageCache = NSCache<NSString, UIImage>()
    private var cancellables = Set<AnyCancellable>()

    private init() {}

    func loadImage(from urlString: String) -> AnyPublisher<UIImage?, Never> {
        if let cachedImage = imageCache.object(forKey: urlString as NSString) {
            return Just(cachedImage).eraseToAnyPublisher()
        }

        guard let url = URL(string: urlString) else {
            return Just(nil).eraseToAnyPublisher()
        }

        return URLSession.shared.dataTaskPublisher(for: url)
            .map { $0.data }
            .map(UIImage.init(data:))
            .handleEvents(receiveOutput: { [weak self] image in
                if let image = image {
                    self?.imageCache.setObject(image, forKey: urlString as NSString)
                }
            })
            .replaceError(with: nil)
            .eraseToAnyPublisher()
    }
}
