//
//  Network.swift
//  
//
//  Created by Yusuf Özgül on 31.01.2021.
//

import Combine
import Foundation

public protocol Networkable {
    func send<T>(requestData: BaseRequestProtocol,
                 modelType: T.Type,
                 decoder: JSONDecoder,
                 urlSession: NetworkProtocol,
                 result: @escaping (Result<T, Error>) -> Void) where T : Decodable
}

public extension Networkable {
    func send<T>(requestData: BaseRequestProtocol,
                 modelType: T.Type,
                 decoder: JSONDecoder = .init(),
                 urlSession: NetworkProtocol = URLSession.shared,
                 result: @escaping (Result<T, Error>) -> Void) where T : Decodable {
        let request = urlSession.createRequest(urlRequest: requestData.request, modelType: modelType, decoder: decoder, urlSession: urlSession)
        
        let requestCancellable = request.sink(receiveCompletion: {
            if case .failure(let error) = $0 { result(.failure(error)) }
            
            requestData.setIsResuming(isResuming: false)
        }, receiveValue: { result(.success($0)) })
        
        requestData.setIsResuming(isResuming: true)
        requestData.setCancellable(cancellable: requestCancellable)
    }
}
