import UIKit

public enum Fonts: String {
    case ibmPlexSerifBold = "IBMPlexSerif-Bold"
    case ibmPlexSansRegular = "IBMPlexSans-Regular"
    case ibmPlexSansSemiBold = "IBMPlexSans-SemiBold"
    case ibmPlexSansBold = "IBMPlexSans-Bold"
}

public extension UIFont {
    static var title: UIFont {
        UIFont(name: Fonts.ibmPlexSerifBold.rawValue, size: 34)!
    }

    static var subtitle: UIFont {
        UIFont(name: Fonts.ibmPlexSansRegular.rawValue, size: 17)!
    }

    static var title2: UIFont {
        UIFont(name: Fonts.ibmPlexSansSemiBold.rawValue, size: 17)!
    }

    static var subtitle2: UIFont {
        UIFont(name: Fonts.ibmPlexSansRegular.rawValue, size: 15)!
    }

    static var title3: UIFont {
        UIFont(name: Fonts.ibmPlexSansSemiBold.rawValue, size: 13)!
    }

    static var textField: UIFont {
        UIFont(name: Fonts.ibmPlexSansRegular.rawValue, size: 17)!
    }

    static var paragraph: UIFont {
        UIFont(name: Fonts.ibmPlexSansRegular.rawValue, size: 17)!
    }

    static var footer: UIFont {
        UIFont(name: Fonts.ibmPlexSansRegular.rawValue, size: 13)!
    }

    static var button: UIFont {
        UIFont(name: Fonts.ibmPlexSansSemiBold.rawValue, size: 17)!
    }

    static var otp: UIFont {
        UIFont(name: Fonts.ibmPlexSansBold.rawValue, size: 17)!
    }
}
