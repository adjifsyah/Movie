//
//  DetailMovieModel.swift
//  Movie
//
//  Created by Apple Josal on 12/04/25.
//

import Foundation

public struct DetailMovieModel: Equatable, Identifiable {
    public var id: Int
    public var title: String
    public var overview: String
    public var backdropPath: String
    public var posterPath: String
    public var releaseDate: String
    public var tagline: String
    public var runtime: Int
    public var voteAverage: Double
    public var voteCount: Int
    public var isFavorite: Bool
    public var genres: [Genre]
    public var productionCompanies: [ProductionCompany]
    
    init(
        id: Int = 0,
        title: String = "",
        overview: String = "",
        backdropPath: String = "",
        posterPath: String = "",
        releaseDate: String = "",
        voteAverage: Double = 0.0,
        tagline: String = "",
        runtime: Int = 0,
        voteCount: Int = 0,
        isFavorite: Bool = false,
        genres: [Genre] = [],
        productionCompanies: [ProductionCompany] = []
    ) {
        self.id = id
        self.title = title
        self.overview = overview
        self.backdropPath = backdropPath
        self.posterPath = posterPath
        self.releaseDate = releaseDate
        self.voteAverage = voteAverage
        self.tagline = tagline
        self.runtime = runtime
        self.voteCount = voteCount
        self.isFavorite = isFavorite
        self.genres = genres
        self.productionCompanies = productionCompanies
    }
}
