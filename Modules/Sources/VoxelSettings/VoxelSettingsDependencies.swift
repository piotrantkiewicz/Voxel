import Foundation
import VoxelAuthentication

public protocol VoxelSettingsDependencies {
    var authService: AuthService { get }
    var userRepository: UserProfileRepository { get }
    var profilePictureRepository: ProfilePictureRepository { get }
}
