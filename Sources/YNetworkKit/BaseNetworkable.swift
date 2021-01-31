//
//  BaseNetworkable.swift
//  
//
//  Created by Yusuf Özgül on 31.01.2021.
//

import Combine
import Foundation

protocol BaseNetworkable: Networkable {
    var requests: [AnyCancellable] { get }
    func cancelAllRequest()
}

extension BaseNetworkable {
    func cancelAllRequest() {
        requests.forEach({ $0.cancel() })
    }
}
