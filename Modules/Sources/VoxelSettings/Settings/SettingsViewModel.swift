import UIKit
import VoxelAuthentication

public final class SettingsViewModel {
    
    struct Header {
        let imageUrl: URL?
        let name: String
        let description: String
    }
    
    var header: Header
    
    var didUpdateHeader: (() -> ())?
    
    let userRepository: UserProfileRepository
    let profilePictureRepository: ProfilePictureRepository
    
    public init(
        userRepository: UserProfileRepository,
        profilePictureRepository: ProfilePictureRepository
    ) {
        self.userRepository = userRepository
        self.profilePictureRepository = profilePictureRepository
        
        header = Header(
            imageUrl: nil,
            name: "~",
            description: "No Desciption"
        )
    }
    
    func fetchUserProfile() {
        Task { [weak self] in
            do {
                guard let profile = try await self?.userRepository.fetchUserProfile()
                else { return }
                
                await MainActor.run { [weak self] in
                    self?.updateHeader(with: profile)
                }
            } catch {
                print(error)
            }
        }
    }
    
    private func updateHeader(with userProfile: UserProfile) {
        header = Header(
            imageUrl: userProfile.profilePictureUrl,
            name: userProfile.fullName,
            description: userProfile.description
        )
        
        didUpdateHeader?()
    }
}
