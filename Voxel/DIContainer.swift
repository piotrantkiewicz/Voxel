import Foundation
import VoxelAuthentication
import VoxelLogin
import VoxelSettings

class DIContainer: VoxelSettingsDependencies, VoxelLoginDependencies {
    let authService: AuthService
    
    let userRepository: UserProfileRepository
    
    let profilePictureRepository: ProfilePictureRepository
    
    init() {
        let authService = AuthServiceLive()
        let userRepository = UserProfileRepositoryLive(authService: authService)
        let profilePictureRepository = ProfilePictureRepositoryLive(
            authService: authService,
            userProfileRepository: userRepository
        )
        self.authService = authService
        self.userRepository = userRepository
        self.profilePictureRepository = profilePictureRepository
    }
}
