//
//  Networkable.swift
//  
//
//  Created by Yusuf Özgül on 31.01.2021.
//

import Combine
import Foundation

public protocol Networkable {
    func send<T>(requestData: RequestModel, modelType: T.Type, result: @escaping (Result<T, ErrorType>) -> Void, finished: @escaping () -> Void) -> Request where T : Decodable
}

public extension Networkable {
    func send<T>(requestData: RequestModel, modelType: T.Type, result: @escaping (Result<T, ErrorType>) -> Void, finished: @escaping () -> Void) -> Request where T : Decodable {
        let request = createRequest(requestData: requestData, modelType: modelType)
        let requestCancellable = request.sink { (status) in
            switch status {
            case .finished:
                finished()
            case .failure(let error):
                result(.failure(error))
            }
        } receiveValue: { (response) in
            result(.success(response))
        }
        return .init(cancellable: requestCancellable, isResuming: true)
    }
    
    private func createRequest<T>(requestData: RequestModel, modelType: T.Type) -> AnyPublisher<T, ErrorType> where T : Decodable {
        var request = URLRequest(url: URL(string: requestData.url)!)
        request.httpMethod = requestData.method.rawValue
        request.httpBody = requestData.body?.toJSONData()
        
        return URLSession.shared.dataTaskPublisher(for: request)
            .tryMap({ element -> Data in
                guard let res = element.response as? HTTPURLResponse else { throw ErrorType.other }
                if res.statusCode == 500 {
                    throw ErrorType.serverError
                }
                return element.data
            })
            .receive(on: RunLoop.main)
            .decode(type: modelType, decoder: JSONDecoder())
            .mapError { error -> ErrorType in
                switch error {
                case DecodingError.dataCorrupted(let context):
                    return .decodeError(context.debugDescription)
                case DecodingError.keyNotFound(let key, let context):
                    return .decodeError("\(key.stringValue) was not found, \(context.debugDescription)")
                case DecodingError.typeMismatch(let type, let context):
                    return .decodeError("\(type) was expected, \(context.debugDescription)")
                case DecodingError.valueNotFound(let type, let context):
                    return .decodeError("no value was found for \(type), \(context.debugDescription)")
                default:
                    return .other
                }
            }
            .eraseToAnyPublisher()
    }
}
