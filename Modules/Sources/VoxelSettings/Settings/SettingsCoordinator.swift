import UIKit
import VoxelCore
import Swinject

public protocol SettingsCoordinator: Coordinator {
    func presentProfileEdit()
}

public class SettingsCoordinatorLive: SettingsCoordinator {
    
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
    
    public func presentProfileEdit() {
        let coordinator = ProfileEditCoordinatorLive(
            navigationController: navigationController,
            container: container
        )
        
        coordinator.start()
    }
}
