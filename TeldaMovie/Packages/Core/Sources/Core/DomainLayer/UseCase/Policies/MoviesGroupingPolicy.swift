//
//  File.swift
//  Core
//
//  Created by Amr on 04/11/2024.
//

import Foundation

final class MoviesGroupingPolicy {
    static func groupingPolicy(movie: PresentableMovie) -> Int {
        return Int(movie.year) ?? 0
    }
}
