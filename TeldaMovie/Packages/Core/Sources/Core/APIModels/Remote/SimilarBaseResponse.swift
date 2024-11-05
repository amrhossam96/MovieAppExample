//
//  SimilarBaseResponse.swift
//  Core
//
//  Created by Amr on 05/11/2024.
//

import Foundation

public struct SimilarBaseResponse: Decodable {
    let page: Int
    let results: [RemoteMoviesModel]
    let totalResults: Int
    let totalPages: Int

    enum CodingKeys: String, CodingKey {
        case page
        case results
        case totalResults = "total_results"
        case totalPages = "total_pages"
    }
}
