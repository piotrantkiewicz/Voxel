import UIKit
import DesignSystem
import VoxelAuthentication
import VoxelSettings

class TabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupViewControllers()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    private func setupUI() {
        view.backgroundColor = .background
        tabBar.barTintColor = .background
        tabBar.tintColor = .accent
    }
    
    private func setupViewControllers() {
        let contacts = UIViewController()
        contacts.tabBarItem = Tab.contacts.tabBarItem
        
        let calls = UIViewController()
        calls.tabBarItem = Tab.calls.tabBarItem
        
        let chats = UIViewController()
        chats.tabBarItem = Tab.chats.tabBarItem
        
        let settings = setupSettings()
        
        viewControllers = [
            contacts,
            calls,
            chats,
            settings
        ]
        
        selectedViewController = settings
    }
    
    private func setupSettings() -> UIViewController {
        
        let authService = AuthServiceLive()
        let userRepository = UserProfileRepositoryLive(authService: authService)
        let viewModel = SettingsViewModel(userRepository: userRepository)
        let settings = SettingsViewController()
        settings.viewModel = viewModel
        
        let settingsNav = UINavigationController(rootViewController: settings)
        settings.tabBarItem = Tab.settings.tabBarItem
        settings.title = Tab.settings.tabBarItem.title
        
        return settingsNav
    }
}
