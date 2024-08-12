import UIKit
import DesignSystem
import VoxelAuthentication
import VoxelSettings
import Swinject

class TabBarController: UITabBarController {
    
    private let container: Container
    
    init(container: Container) {
        self.container = container
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
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
        let viewModel = SettingsViewModel(
            container: container
        )
        let settings = SettingsViewController()
        settings.viewModel = viewModel
        
        let settingsNav = UINavigationController(rootViewController: settings)
        settings.tabBarItem = Tab.settings.tabBarItem
        settings.title = Tab.settings.tabBarItem.title
        
        return settingsNav
    }
}
