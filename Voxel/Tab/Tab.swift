import UIKit

enum Tab {
    case contacts
    case calls
    case chats
    case settings
    
    var tabBarItem: UITabBarItem {
        switch self {
        case .contacts:
            return UITabBarItem(title: "Contacts", image: .contacts, tag: 0)
        case .calls:
            return UITabBarItem(title: "Calls", image: .calls, tag: 0)
        case .chats:
            return UITabBarItem(title: "Chats", image: .chats, tag: 0)
        case .settings:
            return UITabBarItem(title: "Settings", image: .settings, tag: 0)
        }
    }
}
