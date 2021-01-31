#if canImport(UIKit)
import UIKit

public extension UILabel {
    func calculateMaxLines() -> Int {
        let maxSize = CGSize(width: frame.width, height: CGFloat.zero)
        let charSize = font.lineHeight
        let text = self.text ?? ""
        let textSize = text.boundingRect(with: maxSize, options: .usesLineFragmentOrigin, attributes: [.font: font as Any], context: nil)
        let linesRoundedUp = Int(ceil(textSize.height/charSize))
        return linesRoundedUp
    }
}
#endif
