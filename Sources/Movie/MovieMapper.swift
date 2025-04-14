//
//  File.swift
//  
//
//  Created by Apple Josal on 18/02/25.
//

import Foundation
import Core

public struct MovieTransform: Mapper {
    public typealias Response = [MovieResponse]
    public typealias Entity = Any
    public typealias Domain = [MovieDomainModel]
    
    public init() { }
    
    public func transformEntityToDomain(entity: Entity) -> [MovieDomainModel] {
        fatalError("Not implemented")
    }
    
    public func transformResponseToDomain(response: [MovieResponse]) -> [MovieDomainModel] {
        return response.map { movie in
            MovieDomainModel(
                id: movie.id,
                title: movie.title,
                overview: movie.overview,
                backdropPath: movie.backdropPath,
                posterPath: movie.posterPath,
                releaseDate: movie.releaseDate
            )
        }
    }
    
    public func transformDomainToEntity(domain: [MovieDomainModel]) -> Entity {
        fatalError("Not implemented")
    }
}
