import UIKit
import Swinject
import VoxelCore

public protocol ContactInfoCoordinator: Coordinator {
    func presentEditContact()
}

public final class ContactInfoCoordinatorLive: ContactInfoCoordinator {
    private let navigationController: UINavigationController
    private let container: Container
    private let contact: Contact

    public init(
        navigationController: UINavigationController,
        container: Container,
        contact: Contact
    ) {
        self.navigationController = navigationController
        self.container = container
        self.contact = contact
    }

    public func start() {
        let viewModel = ContactInfoViewModel(
            contact: contact,
            coordinator: self
        )
        let controller = ContactInfoViewController()
        controller.viewModel = viewModel
        navigationController.pushViewController(controller, animated: true)
    }

    public func presentEditContact() {
        let coordinator = CreateContactCoordinatorLive(
            navigationController: navigationController,
            container: container,
            mode: .edit(contact)
        )
        coordinator.start()
    }
}
