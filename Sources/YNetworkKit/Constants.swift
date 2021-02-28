//
//  Constants.swift
//  
//
//  Created by Yusuf Özgül on 28.02.2021.
//

public protocol ApiConstantProtocol {
    var defaultDomain: String? { get }
    var defaultHeader: [String : String]? { get }
}

public struct ApiConstant: ApiConstantProtocol {
    public static var apiDefault: ApiConstant = .init()
    private(set) public var defaultDomain: String?
    private(set) public var defaultHeader: [String : String]?
    
    private init() { }

    public mutating func set(defaultDomain: String, defaultHeader: [String : String]? = nil) {
        self.defaultDomain = defaultDomain
        self.defaultHeader = defaultHeader
    }
}
