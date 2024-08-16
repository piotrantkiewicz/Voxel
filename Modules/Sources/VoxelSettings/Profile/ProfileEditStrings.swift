import UIKit
import DesignSystem

enum ProfileEditStrings: String {
    case setNewAvatar = "Set New Avatar"
    case fullName = "FULL NAME"
    case fullNamePlaceholder = "Enter full name"
    case description = "DESCRIPTION"
    case descriptionPlaceholder = "A few words about yourself"
    case descriptionFooter = "Any details, such as what you do"
    case logout = "Log out of your account"
}


extension ProfileTextFieldCell.Model {

    static func fullName(text: String? = nil) -> Self {
        Self(
            placeholder: ProfileEditStrings.fullNamePlaceholder.rawValue,
            header: ProfileEditStrings.fullName.rawValue,
            text: text
        )
    }

    static func description(text: String? = nil) -> Self {
        Self(
            placeholder: ProfileEditStrings.descriptionPlaceholder.rawValue,
            header: ProfileEditStrings.description.rawValue,
            footer: ProfileEditStrings.descriptionFooter.rawValue,
            text: text
        )
    }
}

extension ButtonCell.Model {
    static var logout: Self {
        Self(
            icon: UIImage(resource: .logout),
            title: ProfileEditStrings.logout.rawValue
        )
    }
}
