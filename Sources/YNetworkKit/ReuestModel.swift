//
//  ReuestModel.swift
//  
//
//  Created by Yusuf Özgül on 31.01.2021.
//

import Foundation

public struct RequestModel {
    var method: HttpMethod
    var url: String
    var body: Encodable?
    var header: [String : String]?
    
    public init(url: String, method: HttpMethod = .GET, body: Encodable? = nil, header: [String : String]? = nil) {
        self.method = method
        self.url = url
        self.body = body
        self.header = header
    }
}
