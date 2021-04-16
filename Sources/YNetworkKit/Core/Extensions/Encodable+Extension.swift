//
//  Encodable+Extension.swift
//  
//
//  Created by Yusuf Özgül on 31.01.2021.
//

import Foundation

extension Encodable {
    func toJSONData() -> Data? {
        if let self = self as? String {
            return self.data(using: .utf8)
        }
        
        return try? JSONEncoder().encode(self)
    }
}
