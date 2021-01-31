#if canImport(UIKit)
import UIKit

public extension Int {
    var stringValue: String {
        String(describing: self)
    }
}

public extension Double {
    var stringValue: String {
        String(describing: self)
    }
}

public extension Float {
    var stringValue: String {
        String(describing: self)
    }
}

public extension Data {
    var stringValue: String {
        String(data: self, encoding: .utf8) ?? "Not_Encode"
    }
}
#endif
