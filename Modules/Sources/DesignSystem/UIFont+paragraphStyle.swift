import UIKit

public extension UIFont {
    func paragraphStyle(forLineHight lineHight: CGFloat) -> NSMutableParagraphStyle {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = lineHeight - pointSize - (lineHeight - pointSize)
        return paragraphStyle
    }
}
