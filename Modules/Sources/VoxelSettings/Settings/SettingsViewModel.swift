import UIKit
import VoxelAuthentication

public final class SettingsViewModel {
    
    struct Header {
        let image: UIImage
        let name: String
        let description: String
    }
    
    var header: Header
    
    var didUpdateHeader: (() -> ())?
    
    let userRepository: UserProfileRepository
    
    public init(userRepository: UserProfileRepository) {
        self.userRepository = userRepository
        
        header = Header(
            image: UIImage(resource: .avatar),
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
            image: UIImage(resource: .avatar),
            name: userProfile.fullName,
            description: userProfile.description
        )
        
        didUpdateHeader?()
    }
}
