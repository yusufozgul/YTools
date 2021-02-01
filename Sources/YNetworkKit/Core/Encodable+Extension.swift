//
//  Encodable+Extension.swift
//  
//
//  Created by Yusuf Özgül on 31.01.2021.
//

import Foundation

extension Encodable {
    func toJSONData() -> Data? { try? JSONEncoder().encode(self) }
}
