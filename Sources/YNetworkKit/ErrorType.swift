//
//  ErrorType.swift
//  
//
//  Created by Yusuf Özgül on 31.01.2021.
//

import Foundation

public enum ErrorType: Error {
    case serverError
    case decodeError(String)
    case badUrlError
    case internetError
    case errorMessage(String)
    case other
    
    public var localizedDescription: String {
        switch self {
        case .serverError:
            return "SERVER_ERROR"
        case .decodeError(let message):
            return message
        case .badUrlError:
            return "NETWORK_ERROR"
        case .internetError:
            return "NETWORK_ERROR"
        case .errorMessage(let message):
            return message
        case .other:
            return "OTHER_ERROR"
        }
    }
}
