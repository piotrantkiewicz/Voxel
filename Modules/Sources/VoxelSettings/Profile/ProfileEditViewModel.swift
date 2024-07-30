import UIKit
import VoxelAuthentication

public final class ProfileEditViewModel {
    
    var selectedImage: UIImage?
    var fullName: String = ""
    var description: String = ""
    var profilePictureUrl: URL? = nil
    
    private let userRepository: UserProfileRepository
    private let profilePictureRepository: ProfilePictureRepository
    
    init(
        userRepository: UserProfileRepository,
        profilePictureRepository: ProfilePictureRepository
    ) {
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
}

