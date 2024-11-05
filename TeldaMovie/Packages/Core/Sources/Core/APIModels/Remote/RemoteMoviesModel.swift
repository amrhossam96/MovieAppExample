//
//  RemoteMoviesModel.swift
//  Core
//
//  Created by Amr on 04/11/2024.
//

import Foundation

public struct RemoteBaseResponse: Decodable {
    let page: Int
    let results: [RemoteMoviesModel]
    let totalPages, totalResults: Int?
    
    var isLastPage: Bool {
        return page >= totalPages ?? 0
    }
}

// MARK: - Result
public struct RemoteMoviesModel: Decodable {
    public let adult: Bool?
    public let backdropPath: String?
    public let genreIDS: [Int]
    public let id: Int?
    
    public let originalTitle, overview: String?
    public let popularity: Double?
    public let posterPath, releaseDate, title: String?
    public let video: Bool?
    public let voteAverage: Double?
    public let voteCount: Int?

    enum CodingKeys: String, CodingKey {
        case adult
        case backdropPath = "backdrop_path"
        case genreIDS = "genre_ids"
        case id
        
        case originalTitle = "original_title"
        case overview
        case popularity
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case title
        case video
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }
}

public enum OriginalLanguage: String, Decodable {
    case en
    case fr
    case tl
}
