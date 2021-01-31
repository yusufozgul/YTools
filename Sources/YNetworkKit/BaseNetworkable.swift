//
//  BaseNetworkable.swift
//  
//
//  Created by Yusuf Özgül on 31.01.2021.
//

import Combine
import Foundation

public protocol BaseNetworkable: Networkable {
    var requests: [AnyCancellable] { get }
    func cancelAllRequest()
}

public extension BaseNetworkable {
    func cancelAllRequest() {
        requests.forEach({ $0.cancel() })
    }
}
