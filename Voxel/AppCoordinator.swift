import UIKit
import VoxelCore
import VoxelLogin
import VoxelAuthentication
import Swinject

class AppCoordinator: Coordinator {
    
    private let navigationController: UINavigationController
    private let container: Container

    private var authService: AuthService {
        container.resolve(AuthService.self)!
    }

    init(navigationController: UINavigationController, container: Container) {
        self.navigationController = navigationController
        self.container = container

        subscribeToLogin()
        subscribeToLogout()
    }

    func start() {
        if authService.isAuthenticated {
            navigationController.setViewControllers([setupTabBar()], animated: false)
        } else {
            presentLogin()
        }
    }

    private func presentLogin() {
        let coordinator = PhoneNumberCoordinatorLive(
            navigationController: navigationController,
            container: container
        )

        coordinator.start()
    }

    private func setupTabBar() -> UIViewController {
        TabBarController(container: container)
    }
}

// MARK:  Login

extension AppCoordinator {
    private func subscribeToLogin() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(didLoginSuccessfully),
            name: Notification.Name(AppNotification.didLoginSuccessfully.rawValue),
            object: nil
        )
    }

    @objc
    private func didLoginSuccessfully() {
        navigationController.setViewControllers([setupTabBar()], animated: true)
    }
}

// MARK:  Logout

extension AppCoordinator {

    private func subscribeToLogout() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(didLogout),
            name: Notification.Name(AppNotification.didLogout.rawValue),
            object: nil
        )
    }

    @objc
    private func didLogout() {
        presentLogin()
    }
}
