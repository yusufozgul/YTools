#if canImport(UIKit)
import UIKit

public extension UIView {
    class func loadXib<T: UIView>() -> T {
        return Bundle(for: T.self).loadNibNamed(String(describing: T.self), owner: nil, options: nil)?[0] as? T ?? T()
    }
}
#endif
