import XCTest
import Swinject
import VoxelAuthentication
import VoxelLogin
@testable import Voxel

final class AppCoordinatorTests: XCTestCase {
    
    private var coordinator: AppCoordinator!
    private var navigationController: UINavigationController!
    private var container: Container!
    private var authService: AuthServiceMock!
    
    override func setUp() {
        navigationController = UINavigationController()
        container = Container()
        authService = AuthServiceMock()
        
        container.register(AuthService.self) { _ in
            self.authService
        }
        
        coordinator = AppCoordinator(
            navigationController: navigationController,
            container: container
        )
    }
    
    func test_whenUserIsAuthenticated_thenPresentTabBar() {
        //given
        authService.isAuthenticated = true
        
        //when
        coordinator.start()
        
        //then
        XCTAssertEqual(navigationController.viewControllers.count, 1)
        XCTAssertTrue(navigationController.viewControllers.first is TabBarController)
    }
    
    func test_whenUserIsNotAuthenticated_thenPresentLogin() {
        //given
        authService.isAuthenticated = false
        
        //when
        coordinator.start()
        
        //then
        XCTAssertEqual(navigationController.viewControllers.count, 1)
        XCTAssertTrue(navigationController.viewControllers.first is PhoneNumberViewController)
    }
    
    func test_whenUserCompletesLogin_thenShowTabBar() {
        //when
        NotificationCenter.default.post(.didLoginSuccessfully)
        
        //then
        XCTAssertEqual(navigationController.viewControllers.count, 1)
        XCTAssertTrue(navigationController.viewControllers.first is TabBarController)
    }
    
    func test_whenUserCompletesLogout_thenShowLogin() {
        //when
        NotificationCenter.default.post(.didLogout)
        
        //then
        XCTAssertEqual(navigationController.viewControllers.count, 1)
        XCTAssertTrue(navigationController.viewControllers.first is PhoneNumberViewController)
    }
}






