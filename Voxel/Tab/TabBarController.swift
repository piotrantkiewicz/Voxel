import UIKit
import DesignSystem
import VoxelSettings

class TabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupViewControllers()
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
        
        let settings = SettingsViewController()
        let settingsNav = UINavigationController(rootViewController: settings)
        settings.tabBarItem = Tab.settings.tabBarItem
        settings.title = Tab.settings.tabBarItem.title
        
        viewControllers = [
            contacts,
            calls,
            chats,
            settingsNav
        ]
    }
}
