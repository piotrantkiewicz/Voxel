import UIKit
import VoxelCore
import VoxelAuthentication
import Swinject

public final class ProfileEditViewModel {

    var selectedImage: UIImage?
    var fullName: String = ""
    var description: String = ""
    var profilePictureUrl: URL? = nil

    let coordinator: ProfileEditCoordinator
    
    private let container: Container

    private var authService: AuthService {
        container.resolve(AuthService.self)!
    }
    private var userRepository: UserProfileRepository {
        container.resolve(UserProfileRepository.self)!
    }
    private var profilePictureRepository: ProfilePictureRepository {
        container.resolve(ProfilePictureRepository.self)!
    }

    init(
        container: Container,
        coordinator: ProfileEditCoordinator
    ) {
        self.container = container
        self.coordinator = coordinator

        if let profile = userRepository.profile {
            fullName = profile.fullName ?? ""
            description = profile.description ?? ""
            profilePictureUrl = profile.profilePictureUrl
        }
    }

    func save() async throws {
        try userRepository.saveUserProfile(fullName, description: description)

        if let selectedImage {
            try await profilePictureRepository.upload(selectedImage)
        }

        await MainActor.run {
            coordinator.dismiss()
        }
    }

    func logout() throws {
        try authService.logout()
        NotificationCenter.default.post(.didLogout)
    }
}
