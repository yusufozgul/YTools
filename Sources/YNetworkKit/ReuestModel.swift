//
//  ReuestModel.swift
//  
//
//  Created by Yusuf Özgül on 31.01.2021.
//

import Foundation
import Combine

public protocol BaseRequestProtocol: BaseRequestCoreProtocol {
    var method: HttpMethod { get }
    var url: URL { get }
    var headers: [String : String] { get }
}

public protocol BaseRequestCoreProtocol {
    var request: URLRequest { get }
    
    func setCancellable(cancellable: AnyCancellable)
    func setIsResuming(isResuming: Bool)
}

public class BaseRequestModel: BaseRequestProtocol {
    public var method: HttpMethod
    public var url: URL
    public var headers: [String : String] = [:]
    
    private var cancellable: AnyCancellable?
    private var isRequestResuming: Bool = false
    private var constant: ApiConstantProtocol
    
    public init(constant: ApiConstantProtocol = ApiConstant.apiDefault,
                path: String,
                method: HttpMethod,
                headers: [String : String] = [:]) {
        self.constant = constant
        self.method = method
        self.headers = headers
        if let url = URL(string: (constant.defaultDomain ?? "") + path) {
            self.url = url
        } else {
            preconditionFailure("URL Decode form string failed")
        }
    }
    
    public func cancel() {
        cancellable?.cancel()
    }
    
    public func isResuming() -> Bool {
        isRequestResuming
    }
}

extension BaseRequestModel {
    public var request: URLRequest {
        var request = URLRequest(url: url)
        switch method {
        case let .GET(queryItems):
            var components = URLComponents(url: url, resolvingAgainstBaseURL: false)
            components?.queryItems = queryItems
            guard let url = components?.url else {
                preconditionFailure("URL can't create from components")
            }
            request = URLRequest(url: url)
        case .POST(let data), .PUT(let data):
            request.httpBody = data?.toJSONData()
        default:
            break
        }
        
        request.allHTTPHeaderFields = headers.merging(constant.defaultHeader ?? [:]) { (current, _) in current }
        request.httpMethod = method.rawValue
        return request
    }
    
    public func setCancellable(cancellable: AnyCancellable) {
        self.cancellable = cancellable
    }
    
    public func setIsResuming(isResuming: Bool) {
        self.isRequestResuming = isResuming
    }
}
