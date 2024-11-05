//
//  HomeFeedService.swift
//  Core
//
//  Created by Amr on 04/11/2024.
//

import Foundation
import protocol Networking.APIEndPoint
import enum Networking.HTTPMethod
import typealias Networking.HTTPHeaders

enum HomeFeedService: APIEndPoint {
    case homeFeed
    case movieDetails(Int)
    case similarMovies(Int)
    case cast(Int)
    case search(String)
    
    var path: String {
        switch self {
        case .homeFeed: return "/3/movie/popular"
        case .movieDetails(let id): return "/3/movie/\(id)"
        case .similarMovies(let id): return "/3/movie/\(id)/similar"
        case .cast(let id): return "3/movie/\(id)/credits"
        case .search: return "3/search/movie"
        }
    }
    
    var queryItems: [URLQueryItem]? {
        if case .search(let string) = self {
            return [.init(name: "query", value: string)]
        } else {
            return nil
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .homeFeed, .movieDetails, .similarMovies, .cast, .search:
            .get
        }
    }
    
    var headers: HTTPHeaders {
        return ["Authorization": "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI2OTdkNDM5YWM5OTM1MzhkYTRlM2U2MGI1NGU3NjJjZCIsIm5iZiI6MTczMDcwMDU4MC43MTEwMjcsInN1YiI6IjYxNjQzODQ1OGM0MGY3MDA0MzQ2MzQ2NyIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.EuRCLcPmoXJ1gBlIe5qSSthUkKjNvHULNse2BeCiMdI"]
    }
}
