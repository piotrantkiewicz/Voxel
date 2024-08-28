import Foundation
import VoxelSettings

public struct Contact {
    public let uid: String
    public let name: String
    public var phoneNumber: String {
        userProfile.phoneNumber
    }
    public let userProfile: UserProfile
    public let isMutual: Bool
}

public extension Contact {
    var profilePictureUrl: URL? {
        isMutual ? userProfile.profilePictureUrl : nil
    }
}








