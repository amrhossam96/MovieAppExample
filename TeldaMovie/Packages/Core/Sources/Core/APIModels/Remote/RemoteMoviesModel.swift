//
//  RemoteMoviesModel.swift
//  Core
//
//  Created by Amr on 04/11/2024.
//

import Foundation

// MARK: - Welcome
public struct RemoteBaseResponse: Decodable {
    let page: Int
    let results: [RemoteMoviesModel]
    let totalPages, totalResults: Int
    
    var isLastPage: Bool {
        return page >= totalPages
    }
}

// MARK: - Result
public struct RemoteMoviesModel: Decodable {
    public let adult: Bool?
    public let backdropPath: String?
    public let genreIDS: [Int]
    public let id: Int?
    public let originalLanguage: OriginalLanguage?
    public let originalTitle, overview: String?
    public let popularity: Double?
    public let posterPath, releaseDate, title: String?
    public let video: Bool?
    public let voteAverage: Double?
    public let voteCount: Int?
}

public enum OriginalLanguage: String, Decodable {
    case en
    case fr
    case tl
}
