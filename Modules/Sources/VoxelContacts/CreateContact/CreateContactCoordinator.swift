import UIKit
import Swinject
import VoxelCore

public enum CreateContactMode: Equatable {
    case create
    case edit(Contact)

    public static func == (lhs: CreateContactMode, rhs: CreateContactMode) -> Bool {
        switch (lhs, rhs) {
        case (.create, .create):
            return true
        case (.edit, .edit):
            return true
        default:
            return false
        }
    }
}

public protocol CreateContactCoordinator: Coordinator {
    func dismiss()
}

public final class CreateContactCoordinatorLive: CreateContactCoordinator {
    private let navigationController: UINavigationController
    private let container: Container
    private let mode: CreateContactMode

    public var rootViewController: UIViewController!

    public init(navigationController: UINavigationController, container: Container, mode: CreateContactMode = .create) {
        self.navigationController = navigationController
        self.container = container
        self.mode = mode
    }

    public func start() {
        let viewModel = CreateContactViewModel(
            container: container, 
            coordinator: self,
            mode: mode
        )
        let controller = CreateContactViewController()
        controller.viewModel = viewModel

        navigationController.pushViewController(controller, animated: true)

        self.rootViewController = controller
    }

    public func dismiss() {
        navigationController.popViewController(animated: true)
    }
}
