//
//  File.swift
//  
//
//  Created by Apple Josal on 17/02/25.
//

import Foundation

public enum URLError: LocalizedError {
    case invalidResponse
    case invalidRequest
    case addressUnreachable(URL)
    
    public var errorDescription: String? {
        switch self {
        case .invalidResponse:
            return "The server responded with garbage"
        case .invalidRequest:
            return "Your request is not valid"
        case .addressUnreachable(let url):
            return "\(url.absoluteString) is unreachable."
        }
    }
}
