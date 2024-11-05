//
//  File.swift
//  Core
//
//  Created by Amr on 04/11/2024.
//

import Foundation

final class MoviesGroupingPolicy {
    static func groupingPolicy(movie: PresentableMovie) -> Date {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year], from: movie.year)
        return calendar.date(from: components) ?? movie.year
    }
}
