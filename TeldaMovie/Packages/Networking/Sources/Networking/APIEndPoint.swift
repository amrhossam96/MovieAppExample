//
//  APIEndPoint.swift
//  Networking
//
//  Created by Amr on 04/11/2024.
//  Copyright © 2024 Amr Hossam. All rights reserved.
//

import Foundation

public typealias HTTPHeaders = [String: String]

public protocol APIEndPoint {
    var path: String { get }
    var method: HTTPMethod { get }
    var headers: HTTPHeaders { get }
    var queryItems: [URLQueryItem]? { get }
    var body: Data? { get }

    func urlRequest() -> URLRequest
}

public extension APIEndPoint {
    var baseURL: URL { .init(string: "https://api.themoviedb.org/")! }
    var method: HTTPMethod { .get }
    var queryItems: [URLQueryItem]? { nil }
    var body: Data? { nil }
    
    func urlRequest() -> URLRequest {
        var urlComponents = URLComponents(url: baseURL.appendingPathComponent(path), resolvingAgainstBaseURL: false)
        urlComponents?.queryItems = queryItems
        
        guard let url = urlComponents?.url else {
            fatalError("Invalid URL components")
        }
        var request = URLRequest(url: url)

        for header in headers {
            request.setValue(header.value, forHTTPHeaderField: header.key)
        }
        request.httpMethod = method.rawValue
        request.httpBody = body
        return request
    }
}
