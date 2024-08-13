import UIKit
import VoxelCore
import Swinject

public class ProfileEditCoordinator: Coordinator {
    
    private let navigationController: UINavigationController
    private let container: Container
    
    public init(navigationController: UINavigationController, container: Container) {
        self.navigationController = navigationController
        self.container = container
    }
    
    public func start() {
        let viewModel = ProfileEditViewModel(container: container, coordinator: self)
        let controller = ProfileEditViewController()
        controller.viewModel = viewModel
        navigationController.pushViewController(controller, animated: true)
    }
    
    func dismiss() {
        navigationController.popViewController(animated: true)
    }
}
