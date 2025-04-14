//
//  File.swift
//  
//
//  Created by Apple Josal on 17/02/25.
//

import Core
import Foundation
import RxSwift

// Repository
public class MoviesRepositories<
    RemoteDataSource: DataSource,
    Transformer: Mapper
>: Repository where
    RemoteDataSource.Request == URLRequest,
    RemoteDataSource.Response == [MovieResponse],
    Transformer.Response == [MovieResponse],
    Transformer.Domain == [MovieDomainModel],
    Transformer.Entity == Any {

    public typealias Request = URLRequest
    public typealias Response = [MovieDomainModel]

    private let remote: RemoteDataSource
    private let mapper: Transformer

    public init(remote: RemoteDataSource, mapper: Transformer) {
        self.remote = remote
        self.mapper = mapper
    }

    public func execute(request: URLRequest?) -> Observable<[MovieDomainModel]> {
        remote.execute(request: request)
            .map { response in
                self.mapper.transformResponseToDomain(response: response)
            }
    }
}
