//
//  PresentableFeed.swift
//  Core
//
//  Created by Amr on 04/11/2024.
//

import Foundation

public struct PresentableFeed {
    public var isLastPage: Bool
    public var feed: GroupedMovies
}

public struct GroupedMovies {
    public let groupedMovies: [(Date, [PresentableMovie])]
}
