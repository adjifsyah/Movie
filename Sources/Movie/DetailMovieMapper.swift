//
//  File.swift
//  Movie
//
//  Created by Apple Josal on 12/04/25.
//

import Foundation
import Core

public struct DetailMovieTransform: Mapper {
    public typealias Response = ResponseMovieDetail
    public typealias Entity = MoviesEntityLib
    public typealias Domain = DetailMovieModel
    
    public init() { }
    
    public func transformEntityToDomain(entity: MoviesEntityLib) -> DetailMovieModel {
        DetailMovieModel(
            id: Int(entity.movie_id) ?? 0,
            title: entity.title,
            overview: entity.overview,
            backdropPath: entity.backdrop_path,
            posterPath: entity.poster_path,
            releaseDate: entity.release_date,
            voteAverage: entity.average
        )
    }
    
    public func transformResponseToDomain(response: ResponseMovieDetail) -> DetailMovieModel {
        DetailMovieModel(
            id: response.id,
            title: response.title,
            overview: response.overview,
            backdropPath: response.backdropPath,
            posterPath: response.posterPath,
            releaseDate: response.releaseDate,
            voteAverage: response.voteAverage,
            tagline: response.tagline,
            runtime: response.runtime,
            voteCount: response.voteCount,
            isFavorite: false,
            genres: response.genres,
            productionCompanies: response.productionCompanies
        )
    }
    
    public func transformDomainToEntity(domain: DetailMovieModel) -> MoviesEntityLib {
        let entity = MoviesEntityLib()
        entity.movie_id = String(domain.id)
        entity.title = domain.title
        entity.overview = domain.overview
        entity.average = domain.voteAverage
        entity.release_date = domain.releaseDate
        entity.poster_path = domain.posterPath
        entity.backdrop_path = domain.backdropPath
        return entity
    }
}
