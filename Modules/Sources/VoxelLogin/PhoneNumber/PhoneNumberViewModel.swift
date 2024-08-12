import Foundation
import VoxelAuthentication
import Swinject

public final class PhoneNumberViewModel {
    private var authService: AuthService {
        container.resolve(AuthService.self)!
    }
    
    private let container: Container
    private let coordinator: PhoneNumberCoordinator
    
    public init(container: Container, coordinator: PhoneNumberCoordinator) {
        self.container = container
        self.coordinator = coordinator
    }
    
    public func requestOTP(with phoneNumber: String) async throws{
        try await authService.requestOTP(forPhoneNumber: phoneNumber)
        
        await MainActor.run {
            didRequestOTPSuccessfully(with: phoneNumber)
        }
    }
    
    private func didRequestOTPSuccessfully(with phoneNumber: String) {
        coordinator.presentOTP(with: phoneNumber)
    }
}


