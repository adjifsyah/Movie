
//
//  File.swift
//  
//
//  Created by Apple Josal on 17/02/25.
//

import Foundation
import Core
import RxSwift

public class GetDetailMoviesDataSource: DataSource {
    public typealias Request = Int
    public typealias Response = ResponseMovieDetail
    
//    private let client: HttpClient
    private let remote: RemoteDataSourceLmpl
    
    public init(remote: RemoteDataSourceLmpl) {
//        self.client = client
        self.remote = remote
    }
    
    public func execute(request: Int?) -> Observable<ResponseMovieDetail> {
        self.remote.load(endpoint: "/\(request ?? 0)", method: "GET", params: nil)
            .map { (response: ResponseMovieDetail) in
//                DetailMovieTransform().transformResponseToDomain(response: response)
//                MovieMapper.mapMovieResponseToDomain(input: response.results)
                return response
            }
//        guard let request = request else {
//            return Observable.error(URLError.invalidRequest)
//        }
//        
//        return client.load(request: request)
//            .map { data in
//                do {
//                    let response = try JSONDecoder().decode(ResponseMovieDetail.self, from: data)
//                    return response
//                } catch {
//                    throw URLError.invalidResponse
//                }
//            }
//            .catch { error in
//                return Observable.error(error)
//            }
    }
}
