import UIKit

public extension UIView {
    func setMaskedCorners(_ corners: UIRectCorner) {

        switch corners {
        case .allCorners:
            self.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner, .layerMaxXMaxYCorner, .layerMinXMaxYCorner]
        case [.topLeft, .topRight]:
            self.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        case [.bottomLeft, .bottomRight]:
            self.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
        default:
            self.layer.maskedCorners = []
        }
    }
}
