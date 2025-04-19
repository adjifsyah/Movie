//
//  File.swift
//  Movie
//
//  Created by Apple Josal on 11/04/25.
//

import Foundation

public struct ResponseMovieDetail: Codable {
    public let adult: Bool
    public let backdropPath: String
    public let belongsToCollection: BelongsToCollection
    public let budget: Int
    public let genres: [Genre]
    public let homepage: String
    public let id: Int
    public let imdbID: String
    public let originCountry: [String]
    public let originalLanguage, originalTitle, overview: String
    public let popularity: Double
    public let posterPath: String
    public let productionCompanies: [ProductionCompany]
    public let productionCountries: [ProductionCountry]
    public let releaseDate: String
    public let revenue, runtime: Int
    public let spokenLanguages: [SpokenLanguage]
    public let status, tagline, title: String
    public let video: Bool
    public let voteAverage: Double
    public let voteCount: Int

    enum CodingKeys: String, CodingKey {
        case adult
        case backdropPath = "backdrop_path"
        case belongsToCollection = "belongs_to_collection"
        case budget, genres, homepage, id
        case imdbID = "imdb_id"
        case originCountry = "origin_country"
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case overview, popularity
        case posterPath = "poster_path"
        case productionCompanies = "production_companies"
        case productionCountries = "production_countries"
        case releaseDate = "release_date"
        case revenue, runtime
        case spokenLanguages = "spoken_languages"
        case status, tagline, title, video
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }
    
    public init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.adult = try container.decode(Bool.self, forKey: .adult)
        self.backdropPath = try container.decode(String.self, forKey: .backdropPath)
        self.belongsToCollection = container.decodeDynamicModel(BelongsToCollection.self, forKey: .belongsToCollection)
        self.budget = try container.decode(Int.self, forKey: .budget)
        self.genres = try container.decode([Genre].self, forKey: .genres)
        self.homepage = try container.decode(String.self, forKey: .homepage)
        self.id = try container.decode(Int.self, forKey: .id)
        self.imdbID = try container.decode(String.self, forKey: .imdbID)
        self.originCountry = try container.decode([String].self, forKey: .originCountry)
        self.originalLanguage = try container.decode(String.self, forKey: .originalLanguage)
        self.originalTitle = try container.decode(String.self, forKey: .originalTitle)
        self.overview = try container.decode(String.self, forKey: .overview)
        self.popularity = try container.decode(Double.self, forKey: .popularity)
        self.posterPath = try container.decode(String.self, forKey: .posterPath)
        self.productionCompanies = try container.decode([ProductionCompany].self, forKey: .productionCompanies)
        self.productionCountries = try container.decode([ProductionCountry].self, forKey: .productionCountries)
        self.releaseDate = try container.decode(String.self, forKey: .releaseDate)
        self.revenue = try container.decode(Int.self, forKey: .revenue)
        self.runtime = try container.decode(Int.self, forKey: .runtime)
        self.spokenLanguages = try container.decode([SpokenLanguage].self, forKey: .spokenLanguages)
        self.status = try container.decode(String.self, forKey: .status)
        self.tagline = try container.decode(String.self, forKey: .tagline)
        self.title = try container.decode(String.self, forKey: .title)
        self.video = try container.decode(Bool.self, forKey: .video)
        self.voteAverage = try container.decode(Double.self, forKey: .voteAverage)
        self.voteCount = try container.decode(Int.self, forKey: .voteCount)
    }
}

public struct BelongsToCollection: Codable, DefaultInitializable {
    public let id: Int
    public let name, posterPath, backdropPath: String

    enum CodingKeys: String, CodingKey {
        case id, name
        case posterPath = "poster_path"
        case backdropPath = "backdrop_path"
    }
    
    public init(
        id: Int = 0,
        name: String = "",
        posterPath: String = "",
        backdropPath: String = ""
    ) {
        self.id = id
        self.name = name
        self.posterPath = posterPath
        self.backdropPath = backdropPath
    }
    
    public init() {
        self.init(name: "")
    }
}

public struct Genre: Codable, Equatable {
    public let id: Int
    public let name: String
}

public struct ProductionCompany: Codable, Equatable {
    public let id: Int
    public let logoPath, name, originCountry: String

    enum CodingKeys: String, CodingKey {
        case id
        case logoPath = "logo_path"
        case name
        case originCountry = "origin_country"
    }
    
    public init(
        id: Int = 0,
        logoPath: String = "",
        name: String = "",
        originCountry: String = ""
    ) {
        self.id = id
        self.logoPath = logoPath
        self.name = name
        self.originCountry = originCountry
    }
    
    public init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(Int.self, forKey: .id)
        self.logoPath = container.decodeDynamicString(forKey: .logoPath)
        self.name = try container.decode(String.self, forKey: .name)
        self.originCountry = try container.decode(String.self, forKey: .originCountry)
    }
}

public struct ProductionCountry: Codable {
    let iso3166_1, name: String
    
    public init(iso3166_1: String, name: String) {
        self.iso3166_1 = iso3166_1
        self.name = name
    }

    enum CodingKeys: String, CodingKey {
        case iso3166_1 = "iso_3166_1"
        case name
    }
}

public struct SpokenLanguage: Codable {
    let englishName, iso639_1, name: String
    
    public init(englishName: String, iso639_1: String, name: String) {
        self.englishName = englishName
        self.iso639_1 = iso639_1
        self.name = name
    }

    enum CodingKeys: String, CodingKey {
        case englishName = "english_name"
        case iso639_1 = "iso_639_1"
        case name
    }
}

extension KeyedDecodingContainer {
    func decodeDynamicInt(forKey key: Key) -> Int {
        if let value = try? decode(Int.self, forKey: key) {
            return value
        } else if let doubleValue = try? decode(Double.self, forKey: key) {
            return Int(doubleValue)
        } else if let stringValue = try? decode(String.self, forKey: key), let convertedValue = Int(stringValue) {
            return convertedValue
        } else {
            return 0
        }
    }

    func decodeDynamicDouble(forKey key: Key) -> Double {
        if let value = try? decode(Double.self, forKey: key) {
            return value
        } else if let intValue = try? decode(Int.self, forKey: key) {
            return Double(intValue)
        } else if let stringValue = try? decode(String.self, forKey: key), let convertedValue = Double(stringValue) {
            return convertedValue
        } else {
            return 0.0
        }
    }

    func decodeDynamicString(forKey key: Key) -> String {
        if let value = try? decode(String.self, forKey: key) {
            return value
        } else if let intValue = try? decode(Int.self, forKey: key) {
            return String(intValue)
        } else if let doubleValue = try? decode(Double.self, forKey: key) {
            return String(doubleValue)
        } else {
            return ""
        }
    }
    
    func decodeDynamicModel<T: Decodable & DefaultInitializable>(
        _ type: T.Type,
        forKey key: Key
    ) -> T {
        if let value = try? decode(T.self, forKey: key) {
            return value
        } else {
            return T()
        }
    }
}

protocol DefaultInitializable {
    init()
}
