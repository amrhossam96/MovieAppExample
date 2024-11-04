//
//  PresentableFeed.swift
//  Core
//
//  Created by Amr on 04/11/2024.
//

import Foundation

public struct PresentableFeed {
    public var isLastPage: Bool
    public var movies: GroupedMovies
}

public struct GroupedMovies {
    public var movies: [Int: [PresentableMovie]]
}
