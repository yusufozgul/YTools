//
//  Request.swift
//  
//
//  Created by Yusuf Özgül on 31.01.2021.
//

import Combine
import Foundation

public struct Request {
    public var cancellable: AnyCancellable?
    public var isResuming: Bool = false
    
    public var cancel: Void {
        cancellable?.cancel()
    }
}
