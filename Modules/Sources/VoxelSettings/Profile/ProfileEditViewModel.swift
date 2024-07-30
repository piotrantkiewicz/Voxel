import UIKit
import VoxelAuthentication

public final class ProfileEditViewModel {
    
    var selectedImage: UIImage?
    var fullName: String = ""
    var description: String = ""
    
    private let userRepository: UserProfileRepository
    
    init(userRepository: UserProfileRepository) {
        self.userRepository = userRepository
        
        if let profile = userRepository.profile {
            fullName = profile.fullName
            description = profile.description
        }
    }
    
    func save() throws {
        let profile = UserProfile(
            fullName: fullName,
            description: description
        )
        
        try userRepository.saveUserProfile(profile)
    }
}

