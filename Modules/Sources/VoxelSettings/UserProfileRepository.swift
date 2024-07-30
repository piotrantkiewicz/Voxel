import Foundation
import FirebaseDatabase
import VoxelAuthentication

public struct UserProfile: Codable {
    public let fullName: String
    public let description: String
    
    public init(fullName: String, description: String) {
        self.fullName = fullName
        self.description = description
    }
}

public enum UserProfileRepositoryError: Error {
    case notAuthenticated
}

extension UserProfileRepositoryError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .notAuthenticated:
            return "User is not authenticated."
        }
    }
}

public protocol UserProfileRepository {
    var profile: UserProfile? { get }
    
    func saveUserProfile(_ userProfile: UserProfile) throws
    func fetchUserProfile() async throws -> UserProfile
}

public class UserProfileRepositoryLive: UserProfileRepository {
    
    private let reference: DatabaseReference
    private let authService: AuthService
    
    public var profile: UserProfile?
    
    public init(authService: AuthService = AuthServiceLive()) {
        reference = Database.database().reference()
        self.authService = authService
    }
    
    public func saveUserProfile(_ userProfile: UserProfile) throws {
        guard let user = authService.user else {
            throw UserProfileRepositoryError.notAuthenticated
        }
        
        reference.child("users").child(user.uid).setValue([
            "fullName": userProfile.fullName,
            "description": userProfile.description
        ])
    }
    
    public func fetchUserProfile() async throws -> UserProfile {
        guard let user = authService.user else {
            throw UserProfileRepositoryError.notAuthenticated
        }
        
        let snapshot = try await reference.child("users").child(user.uid).getData()
        let profile = try snapshot.data(as: UserProfile.self)
        
        self.profile = profile
        
        return profile
    }
}
