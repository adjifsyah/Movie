//
//  File.swift
//  Movie
//
//  Created by Apple Josal on 11/04/25.
//

import Foundation
import Core
import RxSwift

public struct GetMovieDetailRepository<
    RemoteDataSource: DataSource,
    MovieLocaleDataSource: LocaleDataSource,
    Transformer: Mapper
>: Repository where RemoteDataSource.Request == DetailMovieModel,
                    RemoteDataSource.Response == ResponseMovieDetail,
                    MovieLocaleDataSource.Request == DetailMovieModel,
                    MovieLocaleDataSource.Response == MoviesEntityLib,
                    Transformer.Response == ResponseMovieDetail,
                    Transformer.Domain == DetailMovieModel,
                    Transformer.Entity == MoviesEntityLib
{
    public typealias Request = DetailMovieModel
    public typealias Response = DetailMovieModel
    
    private let _remote: RemoteDataSource
    private let _locale: MovieLocaleDataSource
    private let _mapper: Transformer
    
    public init(
        remote: RemoteDataSource,
        locale: MovieLocaleDataSource,
        mapper: Transformer
    ) {
        self._remote = remote
        self._locale = locale
        self._mapper = mapper
    }
    
    public func execute(request: DetailMovieModel?) -> RxSwift.Observable<DetailMovieModel> {
        _remote.execute(request: request)
            .flatMap { response -> Observable<DetailMovieModel> in
                return _locale.list(request: nil)
                    .map { list in
                        var result = _mapper.transformResponseToDomain(response: response)
                        let isFav = list.contains(where: { $0.movie_id == String(response.id) })
                        result.isFavorite = isFav
                        return result
                    }
            }
    }
}
