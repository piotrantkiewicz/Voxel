import UIKit

public extension UINavigationController {
    
    static func styleVoxel() {
        let appearance = UINavigationBar.appearance()
        
        appearance.tintColor = .accent
        
        let image = UIImage(resource: .chevronLeft)
        
        appearance.backIndicatorImage = image
        appearance.backIndicatorTransitionMaskImage = image
        
        appearance.topItem?.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: self, action: nil)
    }
}
