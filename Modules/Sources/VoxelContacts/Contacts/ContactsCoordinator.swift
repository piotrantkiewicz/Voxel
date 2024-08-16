import UIKit
import Swinject
import VoxelCore

public protocol ContactsCoordinator: Coordinator {
    func presentAddContact()
    func showContactInfo(for contact: Contact)
}

public final class ContactsCoordinatorLive: ContactsCoordinator {

    private let navigationController: UINavigationController
    private let container: Container

    public var rootViewController: UIViewController!

    public init(navigationController: UINavigationController, container: Container) {
        self.navigationController = navigationController
        self.container = container
    }

    public func start() {
        let viewModel = ContactsViewModel(
            container: container,
            coordinator: self
        )
        let controller = ContactsViewController()
        controller.viewModel = viewModel
        navigationController.setViewControllers([controller], animated: false)

        self.rootViewController = controller
    }

    public func presentAddContact() {
        let coordinator = CreateContactCoordinatorLive(
            navigationController: navigationController,
            container: container
        )
        coordinator.start()
    }

    public func showContactInfo(for contact: Contact) {
        let coordinator = ContactInfoCoordinatorLive(
            navigationController: navigationController,
            container: container,
            contact: contact
        )
        coordinator.start()
    }
}

