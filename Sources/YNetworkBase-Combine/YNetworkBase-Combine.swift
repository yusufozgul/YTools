import Foundation
import Combine

public enum HttpMethod: String {
    case GET
    case POST
    case DELETE
    case PUT
}

public enum ErrorType: Error {
    case serverError
    case decodeError(String)
    case badUrlError
    case internetError
    case errorMessage(String)
    case other
    
    var localizedDescription: String {
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

public class API<ResponseBody: Codable> {
    private let apiUrl: URL
    private let reqBody: Data?
    private let apiMethod: HttpMethod
    
    public init(url: String, body: Data?, method: HttpMethod) throws {
        if let apiUrl = URL(string: url) {
            self.apiUrl = apiUrl
        } else {
            throw ErrorType.badUrlError
        }
        
        reqBody = body
        apiMethod = method
    }
    
    private var request: AnyPublisher<ResponseBody, ErrorType> {
        var request = URLRequest(url: apiUrl)
        request.httpMethod = apiMethod.rawValue
        request.httpBody = reqBody
        
        return URLSession.shared.dataTaskPublisher(for: request)
            .tryMap({ element -> Data in
                guard let res = element.response as? HTTPURLResponse else { throw ErrorType.other }
                if res.statusCode == 500 {
                    throw ErrorType.serverError
                }
                return element.data
            })
            .receive(on: RunLoop.main)
            .decode(type: ResponseBody.self, decoder: JSONDecoder())
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
    
    public func request(_ result: @escaping (_ result: Subscribers.Completion<ErrorType>) -> Void, _ value: @escaping (_ value: ResponseBody?) -> Void) -> AnyCancellable {
        return self.request.sink(receiveCompletion: { (error) in
            result(error)
        }) { (response) in
            value(response)
        }
    }
}
