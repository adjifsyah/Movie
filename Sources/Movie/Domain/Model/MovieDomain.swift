//
//  File.swift
//  
//
//  Created by Apple Josal on 17/02/25.
//

import Foundation

public struct MovieDomainModel {
    public let id: Int
    public let title: String
    public let overview: String
    public let backdropPath: String
    public let posterPath: String
    public let releaseDate: String
    public let isFavorite: Bool
    
    public init(
        id: Int = 0,
        title: String = "",
        overview: String = "",
        backdropPath: String = "",
        posterPath: String = "",
        releaseDate: String = "",
        isFavorite: Bool = false
    ) {
        self.id = id
        self.title = title
        self.overview = overview
        self.backdropPath = backdropPath
        self.posterPath = posterPath
        self.releaseDate = releaseDate
        self.isFavorite = isFavorite
    }
}
