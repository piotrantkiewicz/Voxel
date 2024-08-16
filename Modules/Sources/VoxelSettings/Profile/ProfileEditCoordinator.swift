import UIKit
import VoxelCore
import Swinject

class ProfileEditCoordinator: Coordinator {

    private let navigationController: UINavigationController
    private let container: Container

    init(navigationController: UINavigationController, container: Container) {
        self.navigationController = navigationController
        self.container = container
    }

    func start() {
        let viewModel = ProfileEditViewModel(
            container: container,
            coordinator: self
        )
        
        let controller = ProfileEditViewController()
        controller.viewModel = viewModel
        navigationController.pushViewController(controller, animated: true)
    }

    func dismiss() {
        navigationController.popViewController(animated: true)
    }
}
