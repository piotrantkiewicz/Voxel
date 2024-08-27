import Foundation

public struct UserProfile: Codable {
    public let phoneNumber: String
    public let fullName: String?
    public let description: String?
    public let profilePictureUrl: URL?

    public init(
        phoneNumber: String,
        fullName: String?,
        description: String?,
        profilePictureUrl: URL? = nil
    ) {
        self.phoneNumber = phoneNumber
        self.fullName = fullName
        self.description = description
        self.profilePictureUrl = profilePictureUrl
    }
}
