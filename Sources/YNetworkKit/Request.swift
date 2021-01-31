//
//  Request.swift
//  
//
//  Created by Yusuf Özgül on 31.01.2021.
//

import Combine
import Foundation

struct Request {
    var cancellable: AnyCancellable?
    var isResuming: Bool = false
    
    var cancel: Void {
        cancellable?.cancel()
    }
}
