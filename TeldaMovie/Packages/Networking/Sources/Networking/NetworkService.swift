//
//  NetworkService.swift
//  Networking
//
//  Created by Amr on 04/11/2024.
//

import Foundation
import Combine

public protocol NetworkService {
    func request<T: Decodable>(_ endpoint: APIEndPoint) -> AnyPublisher<T, Error>
}

extension NetworkService {
    public func request<T>(_ endpoint: any APIEndPoint) -> AnyPublisher<T, any Error> where T : Decodable {
        let request = endpoint.urlRequest()
        
        return URLSession.shared.dataTaskPublisher(for: request)
            .map(\.data)
            .decode(type: T.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}
