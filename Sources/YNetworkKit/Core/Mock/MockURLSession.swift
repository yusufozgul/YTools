//
//  MockURLSession.swift
//  
//
//  Created by Yusuf Özgül on 28.02.2021.
//

import Combine
import Foundation

public class MockURLSession: NetworkProtocol {
    let bundle: Bundle
    
    /// MockURLSession: Request handle json file content
    /// - Parameter bundle: Your json file bundle
    public init(bundle: Bundle) {
        self.bundle = bundle
    }
    
    public func dataTaskPublisher(for request: URLRequest) -> URLSession.DataTaskPublisher {
        let stubReply = request.url?.lastPathComponent ?? "stub_error"
        return URLSession.shared.dataTaskPublisher(for: bundle.url(forResource: stubReply, withExtension: "json")!)
    }
}
