//
//  ReuestModel.swift
//  
//
//  Created by Yusuf Özgül on 31.01.2021.
//

import Foundation
import Combine

public class BaseRequestModel {
    var method: HttpMethod
    var url: String
    var body: Encodable?
    var header: [String : String]?
    
    private var cancellable: AnyCancellable?
    private var isRequestResuming: Bool = false
    
    public init(domain: String, path: String, params: [String : String]? = nil, method: HttpMethod = .GET, body: Encodable? = nil, header: [String : String]? = nil) {
        self.method = method
        self.url = domain + path
        self.body = body
        self.header = header
    }
    
    public func cancel() {
        cancellable?.cancel()
    }
    
    public func isResuming() -> Bool {
        isRequestResuming
    }
}

extension BaseRequestModel {
    func setCancellable(cancellable: AnyCancellable) {
        self.cancellable = cancellable
    }
    
    func setIsResuming(isResuming: Bool) {
        self.isRequestResuming = isResuming
    }
}
