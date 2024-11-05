//
//  File.swift
//  Presentation
//
//  Created by Amr on 05/11/2024.
//

import Foundation

protocol MovieDetailsDataSourceProtocol {
    var movieID: Int { get }
}

struct MovieDetailsDataSource: MovieDetailsDataSourceProtocol {
    var movieID: Int = 0
}
