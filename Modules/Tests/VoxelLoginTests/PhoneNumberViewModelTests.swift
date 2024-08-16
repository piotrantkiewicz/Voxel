import XCTest
import Swinject
import VoxelAuthentication
import VoxelMocks
@testable import VoxelLogin

class PhoneNumberViewModelTests: XCTestCase {

    private var viewModel: PhoneNumberViewModel!
    private var container: Container!
    private var authService: AuthServiceMock!
    private var coordinator: PhoneNumberCoordinatorMock!
    private let phoneNumber: String = "+4915155555555"

    override func setUp() {
        container = Container()
        authService = AuthServiceMock()
        coordinator = PhoneNumberCoordinatorMock()

        container.register(AuthService.self) { _ in
            self.authService
        }

        viewModel = PhoneNumberViewModel(
            container: container,
            coordinator: coordinator
        )
    }

    func test_whenRequestOTP_thenShouldRequestAuthService() async throws {
        // when
        try await viewModel.requestOTP(with: phoneNumber)
        // then
        XCTAssertEqual(authService.didRequestOTP.count, 1)
        XCTAssertEqual(authService.didRequestOTP.first, phoneNumber)
    }

    func test_whenRequestOTPFails_thenShouldThrowAnError() async {
        // given
        authService.shouldThrowOnRequestOTP = true
        // when
        do {
            try await viewModel.requestOTP(with: phoneNumber)
            XCTFail("Should throw an error")
        } catch {
            // then
            XCTAssertTrue(error is MockError)
        }
    }

    func test_whenOTPRequestSucceeds_thenShouldPresentOTP() async throws {
        // when
        try await viewModel.requestOTP(with: phoneNumber)
        // then
        XCTAssertEqual(coordinator.didPresentOTP.count, 1)
        XCTAssertEqual(coordinator.didPresentOTP.first, phoneNumber)
    }
}
