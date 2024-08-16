import Foundation
@testable import VoxelSettings

class UserProfileRepositoryMock: UserProfileRepository {
    var profile: UserProfile?
    
    var didSaveUserProfile = [UserProfile]()
    func saveUserProfile(_ userProfile: UserProfile) throws {
        didSaveUserProfile.append(userProfile)
    }
    
    var didFetchUserProfile: Int = 0
    
    func fetchUserProfile() async throws -> UserProfile {
        didFetchUserProfile += 1
        return UserProfile(fullName: "John", description: "Dev")
    }
    
    func saveProfilePictureUrl(_ url: URL) throws {
        
    }
}
