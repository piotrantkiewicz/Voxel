import UIKit

public extension UIFont {
    func paragraphStyle(forLineHeight lineHeight: CGFloat) -> NSMutableParagraphStyle {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = lineHeight - pointSize - (lineHeight - pointSize)
        return paragraphStyle
    }
}
