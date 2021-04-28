//
//  URLSession+Extension.swift
//  
//
//  Created by Yusuf Özgül on 28.02.2021.
//

import Combine
import Foundation

public protocol NetworkProtocol {
    func dataTaskPublisher(for urlRequest: URLRequest) -> URLSession.DataTaskPublisher
    func createRequest<T>(urlRequest: URLRequest, modelType: T.Type, decoder: JSONDecoder, urlSession: NetworkProtocol) -> AnyPublisher<T, Error> where T : Decodable
}

extension NetworkProtocol {
    public func createRequest<T>(urlRequest: URLRequest,
                                 modelType: T.Type,
                                 decoder: JSONDecoder,
                                 urlSession: NetworkProtocol) -> AnyPublisher<T, Error> where T : Decodable {
        return urlSession.dataTaskPublisher(for: urlRequest)
            .mapError(NetworkableError.networking)
            .map(\.data)
            .decode(type: modelType, decoder: decoder)
            .mapError(NetworkableError.decoding)
            .eraseToAnyPublisher()
    }
}

extension URLSession: NetworkProtocol { }
