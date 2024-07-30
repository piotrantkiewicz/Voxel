import UIKit
import VoxelAuthentication
import VoxelCore

public final class ProfileEditViewModel {
    
    var selectedImage: UIImage?
    var fullName: String = ""
    var description: String = ""
    var profilePictureUrl: URL? = nil
    
    private let authService: AuthService
    private let userRepository: UserProfileRepository
    private let profilePictureRepository: ProfilePictureRepository
    
    init(
        authService: AuthService,
        userRepository: UserProfileRepository,
        profilePictureRepository: ProfilePictureRepository
    ) {
        self.authService = authService
        self.userRepository = userRepository
        self.profilePictureRepository = profilePictureRepository
        
        if let profile = userRepository.profile {
            fullName = profile.fullName
            description = profile.description
            profilePictureUrl = profile.profilePictureUrl
        }
    }
    
    func save() async throws {
        let profile = UserProfile(
            fullName: fullName,
            description: description
        )
        
        try userRepository.saveUserProfile(profile)
        
        if let selectedImage {
            try await profilePictureRepository.upload(selectedImage)
        }
    }
    
    func logout() throws {
        try authService.logout()
        NotificationCenter.default.post(.didLogout)
    }
}

