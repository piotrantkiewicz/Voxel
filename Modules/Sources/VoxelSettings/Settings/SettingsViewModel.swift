import UIKit
import VoxelAuthentication
import Swinject

enum SettingsStrings: String {
    case placeholderName = "~"
    case placeholderDescription = "No description"
}

public final class SettingsViewModel {

    struct Header {
        let imageUrl: URL?
        let name: String
        let description: String
    }

    var header: Header

    var didUpdateHeader: (() -> ())?

    private let coordinator: SettingsCoordinator
    private let container: Container

    private var userRepository: UserProfileRepository {
        container.resolve(UserProfileRepository.self)!
    }

    public init(
        container: Container,
        coordinator: SettingsCoordinator
    ) {
        self.container = container
        self.coordinator = coordinator

        header = Header(
            imageUrl: nil,
            name: SettingsStrings.placeholderName.rawValue,
            description: SettingsStrings.placeholderDescription.rawValue
        )
    }

    func presentProfileEdit() {
        coordinator.presentProfileEdit()
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
            name: userProfile.fullName?.nillIfEmpty ?? SettingsStrings.placeholderName.rawValue,
            description: userProfile.description?.nillIfEmpty ?? SettingsStrings.placeholderDescription.rawValue
        )

        didUpdateHeader?()
    }
}

extension String {
    var nillIfEmpty: String? {
        isEmpty ? nil : self
    }
}
