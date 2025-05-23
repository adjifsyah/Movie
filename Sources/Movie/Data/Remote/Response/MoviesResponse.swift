//
//  File.swift
//  
//
//  Created by Apple Josal on 17/02/25.
//

import Foundation
import Core

public struct NowPlayingMoviesResponse: Codable {
    public let page: Int
    public let results: [MovieResponse]
    public let totalPages: Int
    public let totalResults: Int

    enum CodingKeys: String, CodingKey {
        case page = "page"
        case results = "results"
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
    
    public init(
        page: Int = 0,
        results: [MovieResponse] = [],
        totalPages: Int = 0,
        totalResults: Int = 0
    ) {
        self.page = page
        self.results = results
        self.totalPages = totalPages
        self.totalResults = totalResults
    }
}

public struct MovieResponse: Codable {
    let adult: Bool
    let backdropPath: String
    let genreIDS: [Int]
    public let id: Int
    let originalLanguage: String
    let originalTitle: String
    let overview: String
    let popularity: Double
    let posterPath: String
    let releaseDate: String
    let title: String
    let video: Bool
    let voteAverage: Double
    let voteCount: Int

    enum CodingKeys: String, CodingKey {
        case adult = "adult"
        case backdropPath = "backdrop_path"
        case genreIDS = "genre_ids"
        case id = "id"
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case overview = "overview"
        case popularity = "popularity"
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case title = "title"
        case video = "video"
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }
    
    public init(
        adult: Bool = false,
        backdropPath: String = "",
        genreIDS: [Int] = [],
        id: Int = 0,
        originalLanguage: String = "",
        originalTitle: String = "",
        overview: String = "",
        popularity: Double = 0.0,
        posterPath: String = "",
        releaseDate: String = "",
        title: String = "",
        video: Bool = false,
        voteAverage: Double = 0.0,
        voteCount: Int = 0
    ) {
        self.adult = adult
        self.backdropPath = backdropPath
        self.genreIDS = genreIDS
        self.id = id
        self.originalLanguage = originalLanguage
        self.originalTitle = originalTitle
        self.overview = overview
        self.popularity = popularity
        self.posterPath = posterPath
        self.releaseDate = releaseDate
        self.title = title
        self.video = video
        self.voteAverage = voteAverage
        self.voteCount = voteCount
    }
}
