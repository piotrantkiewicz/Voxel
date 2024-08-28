import Foundation
import FirebaseDatabase
import VoxelAuthentication

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

    func saveUserProfile(_ fullname: String, description: String) throws
    func fetchUserProfile() async throws -> UserProfile
    func saveProfilePictureUrl(_ url: URL) throws
}

public class UserProfileRepositoryLive: UserProfileRepository {

    private let reference: DatabaseReference
    private let authService: AuthService

    public var profile: UserProfile?

    public init(authService: AuthService = AuthServiceLive()) {
        reference = Database.database().reference()
        self.authService = authService
    }

    public func saveUserProfile(_ fullName: String, description: String) throws {
        guard let user = authService.user else {
            throw UserProfileRepositoryError.notAuthenticated
        }

        reference.child("users").child(user.uid).updateChildValues([
            "fullName": fullName,
            "description": description
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

    public func saveProfilePictureUrl(_ url: URL) throws {
        guard let user = authService.user else {
            throw UserProfileRepositoryError.notAuthenticated
        }

        reference.child("users").child(user.uid).updateChildValues([
            "profilePictureUrl": url.absoluteString
        ])
    }
}
