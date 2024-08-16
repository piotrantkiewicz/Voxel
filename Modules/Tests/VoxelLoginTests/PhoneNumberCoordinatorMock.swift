import Foundation
import VoxelLogin

class PhoneNumberCoordinatorMock: PhoneNumberCoordinator {

    var didPresentOTP: [String] = []

    func presentOTP(with phoneNumber: String) {
        didPresentOTP.append(phoneNumber)
    }

    func start() {}
}
