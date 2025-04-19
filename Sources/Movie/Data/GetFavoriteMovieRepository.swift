//
//  File.swift
//  Movie
//
//  Created by Apple Josal on 19/04/25.
//

import Foundation
import Core
import RxSwift

public struct GetFavoriteMovieRepository<
    MovieLocaleDataSource: LocaleDataSource,
    Transformer: Mapper
>: Repository where MovieLocaleDataSource.Request == DetailMovieModel,
                    MovieLocaleDataSource.Response == MoviesEntityLib,
                    Transformer.Response == ResponseMovieDetail,
                    Transformer.Domain == DetailMovieModel,
                    Transformer.Entity == MoviesEntityLib
{
    public typealias Request = DetailMovieModel
    public typealias Response = DetailMovieModel
    
    private let _locale: MovieLocaleDataSource
    private let _mapper: Transformer
    
    public init(
        locale: MovieLocaleDataSource,
        mapper: Transformer
    ) {
        self._locale = locale
        self._mapper = mapper
    }
    
    public func execute(request: DetailMovieModel?) -> RxSwift.Observable<DetailMovieModel> {
        guard let _request = request else {
            return .just(DetailMovieModel(id: 0, title: "", overview: "", posterPath: "", releaseDate: "", voteAverage: 0.0))
        }
        
        return _locale.list(request: nil)
            .flatMap { movies -> Observable<DetailMovieModel> in
                if let _ = movies.first(where: { $0.movie_id == String(_request.id) }) {
                    // Jika sudah ada, hapus dari Realm
                    return _locale.delete(id: _request.id)
                        .map { _ in
                            var result = _request
                            result.isFavorite = false
                            return result
                        }
                } else {
                    // Kalau belum ada, tambahkan ID saja ke Realmxx
                    return _locale.add(entity: _mapper.transformDomainToEntity(domain: _request))
                        .map { _ in
                            var result = _request
                            result.isFavorite = true
                            return result
                        }
                }
            }
    }
}
