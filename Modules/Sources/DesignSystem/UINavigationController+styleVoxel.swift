import UIKit

public extension UINavigationController {
    func styleVoxel() {
        navigationBar.tintColor = .accent
        
        let image = UIImage(resource: .chevronLeft)
        
        navigationBar.backIndicatorImage = image
        navigationBar.backIndicatorTransitionMaskImage = image
        
        navigationBar.topItem?.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: self, action: nil)
    }
}
