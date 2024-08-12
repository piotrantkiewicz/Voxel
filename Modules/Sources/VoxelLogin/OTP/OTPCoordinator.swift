import UIKit
import VoxelCore
import Swinject

public class OTPCoordinator: Coordinator {
    
    private let navigationController: UINavigationController
    private let container: Container
    private let phoneNumber: String
    
    public init(navigationController: UINavigationController, container: Container, phoneNumber: String) {
        self.navigationController = navigationController
        self.container = container
        self.phoneNumber = phoneNumber
    }
    
    public func start() {
        let viewController = OTPViewController()
        viewController.viewModel = OTPViewModel(container: container, phoneNumber: phoneNumber)
        navigationController.pushViewController(viewController, animated: true)
    }
}
