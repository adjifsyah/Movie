//
//  File.swift
//  Movie
//
//  Created by Apple Josal on 19/04/25.
//

import Foundation
import Core
import RxSwift

public struct GetListFavoriteMovieRepository<
    MovieLocaleDataSource: LocaleDataSource,
    Transformer: Mapper
>: Repository where
                    MovieLocaleDataSource.Request == DetailMovieModel,
                    MovieLocaleDataSource.Response == MoviesEntityLib,
                    Transformer.Domain == [DetailMovieModel],
                    Transformer.Entity == [MoviesEntityLib]
{
    public typealias Request = DetailMovieModel
    public typealias Response = [DetailMovieModel]
    
    private let _locale: MovieLocaleDataSource
    private let _mapper: Transformer
    
    public init(
        locale: MovieLocaleDataSource,
        mapper: Transformer
    ) {
        self._locale = locale
        self._mapper = mapper
    }
    
    public func execute(request: DetailMovieModel?) -> RxSwift.Observable<[DetailMovieModel]> {
        return _locale.list(request: request)
            .map { entities in
                _mapper.transformEntityToDomain(entity: entities)
            }
    }
}
