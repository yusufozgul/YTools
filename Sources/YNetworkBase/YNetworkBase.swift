import Foundation

/// Send netork request and return result data
public class ApiService<T: Decodable> {
    
    public init() { }
    
    /// Send netork request and return result data
    /// - Parameters:
    ///   - request: `ApiRequestProtocol` for request detail.
    ///   - completion: If `result` is error return `ApiError` otherwise return `T` type
    public func getData(request: ApiRequestProtocol, completion: @escaping (Result<T, ApiError>) -> Void) {
        guard let urlString = request.url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed), let url = URL(string: urlString) else {
            completion(.failure(.urlEncode))
            return
        }
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = request.method.rawValue
        urlRequest.httpBody = request.body?.toJSONData()
        
        for (key, value) in request.header ?? [:] {
            urlRequest.addValue(value, forHTTPHeaderField: key)
        }
        
        let task = URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            guard error == nil else {
                completion(.failure(.network(errorMessage: error?.localizedDescription ?? "unexpected_error")))
                return
            }
            if let data = data {
                completion(ParseFromData<T>.parse(data: data))
            }
        }
        task.resume()
    }
}
