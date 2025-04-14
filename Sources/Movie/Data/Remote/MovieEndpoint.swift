//
//  File.swift
//  
//
//  Created by Apple Josal on 17/02/25.
//

import Foundation
import Core

public enum MovieEndpoint {
    case list
}

extension MovieEndpoint: Endpoint {
    public var baseURL: String {
        "https://api.themoviedb.org"
    }
    
    public var path: String {
        "/3/movie/now_playing"
    }
    
    public var method: HttpMethod {
        .get
    }
    
    public var headers: [String : String]? {
        nil
    }
    
    public var body: Data? {
        nil
    }
    
    public var queryParameters: [String : String]? {
        guard let apiKey = Bundle.main.infoDictionary?["Api Key"] as? String else { return nil }
        return [
            "api_key": apiKey
        ]
    }
}
