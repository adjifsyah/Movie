// The Swift Programming Language
// https://docs.swift.org/swift-book

import Core

public struct FavoriteMovieTransform: Mapper {
    public typealias Response = [MovieResponse]
    public typealias Entity = [MoviesEntityLib]
    public typealias Domain = [DetailMovieModel]
    
    public init() { }
    
    public func transformEntityToDomain(entity: [MoviesEntityLib]) -> [DetailMovieModel] {
        entity.map { model in
            DetailMovieModel(
                id: Int(model.movie_id) ?? 0,
                title: model.title,
                overview: model.overview,
                backdropPath: model.backdrop_path,
                posterPath: model.poster_path,
                releaseDate: model.release_date,
                voteAverage: model.average
            )
        }
    }
    
    public func transformResponseToDomain(response: [MovieResponse]) -> [DetailMovieModel] {
        fatalError("Not implemented")
    }
    
    public func transformDomainToEntity(domain: [DetailMovieModel]) -> [MoviesEntityLib] {
        fatalError("Not implemented")
    }
}
