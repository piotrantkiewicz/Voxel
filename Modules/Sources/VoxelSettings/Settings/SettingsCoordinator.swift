import UIKit
import VoxelCore
import Swinject

public class SettingsCoordinator: Coordinator {
    
    private let navigationController: UINavigationController
    private let container: Container
    
    public var rootViewController: UIViewController!
    
    public init(navigationController: UINavigationController, container: Container) {
        self.navigationController = navigationController
        self.container = container
    }
    
    public func start() {
        let viewModel = SettingsViewModel(
            container: container,
            coordinator: self
        )
        let controller = SettingsViewController()
        controller.viewModel = viewModel
        navigationController.setViewControllers([controller], animated: false)
        
        self.rootViewController = controller
    }
    
    func presentProfileEdit() {
        let coordinator = ProfileEditCoordinator(
            navigationController: navigationController,
            container: container
        )
        
        coordinator.start()
    }
}
