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
>: Repository where RemoteDataSource.Request == Int,
                    RemoteDataSource.Response == ResponseMovieDetail,
                    MovieLocaleDataSource.Request == Int,
                    MovieLocaleDataSource.Response == MoviesEntityLib,
                    Transformer.Response == ResponseMovieDetail,
                    Transformer.Domain == DetailMovieModel,
                    Transformer.Entity == MoviesEntityLib
{
    public typealias Request = Int
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
    
    public func execute(request: Int?) -> RxSwift.Observable<DetailMovieModel> {
        _remote.execute(request: request)
            .map { response in
                var result = _mapper.transformResponseToDomain(response: response)
                _locale.list(request: result.id)
                    .map { list in
                        if let favorite = list.first(where: { (Int($0.movie_id) ?? 0) == result.id }) {
                            result.isFavorite = (Int(favorite.movie_id) ?? 0) == result.id
                        }
                    }
                
                return result
            }
    }
}
