//
//  Method.swift
//  
//
//  Created by Yusuf Özgül on 31.01.2021.
//

import Foundation

public enum HttpMethod {
    case GET([URLQueryItem])
    case POST(Encodable?)
    case DELETE
    case PUT(Encodable?)
    
    public var rawValue: String {
        switch self {
        case .GET:
            return "GET"
        case .POST:
            return "POST"
        case .DELETE:
            return "DELETE"
        case .PUT:
            return "PUT"
        }
    }
}
