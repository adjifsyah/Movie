//
//  File.swift
//  
//
//  Created by Apple Josal on 17/02/25.
//

import Foundation
import Core
import RxSwift

public class GetMoviesDataSource: DataSource {
    public typealias Request = URLRequest
    public typealias Response = [MovieResponse]
    
    private let client: HttpClient
    
    public init(client: HttpClient) {
        self.client = client
    }
    
    public func execute(request: URLRequest?) -> Observable<[MovieResponse]> {
        guard let request = request else {
            return Observable.error(URLError.invalidRequest)
        }
        
        return client.load(request: request)
            .map { data in
                do {
                    let response = try JSONDecoder().decode(NowPlayingMoviesResponse.self, from: data)
                    return response.results
                } catch {
                    throw URLError.invalidResponse
                }
            }
            .catch { error in
                return Observable.error(error)
            }
    }
}
