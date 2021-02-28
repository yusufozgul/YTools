//
//  ErrorType.swift
//  
//
//  Created by Yusuf Özgül on 31.01.2021.
//

import Foundation

public enum Error: Swift.Error {
    case networking(URLError)
    case decoding(Swift.Error)
    
    /// more detailed networking and decoding error messages. NOT Localized Description
    public var detailedDescription: String {
        switch self {
        case .networking(let error):
            return "URL: \(String(describing: error.failingURL?.absoluteString))\nCODE: \(error.code)\n DESCRIPTION: \(error.localizedDescription)"
        case .decoding(let error):
            switch error {
            case DecodingError.dataCorrupted(let context):
                return context.debugDescription
            case DecodingError.keyNotFound(let key, let context):
                return "\(key.stringValue) was not found, \(context.debugDescription)"
            case DecodingError.typeMismatch(let type, let context):
                return "\(type) was expected, \(context.debugDescription)"
            case DecodingError.valueNotFound(let type, let context):
                return "no value was found for \(type), \(context.debugDescription)"
            default:
                return "other decoding error"
            }
        }
    }
}
