import XCTest
import Swinject
import VoxelAuthentication
import VoxelMocks
@testable import VoxelLogin

class OTPViewModelTests: XCTestCase {
    private var viewModel: OTPViewModel!
    private var container: Container!
    private var authService: AuthServiceMock!
    private var phoneNumber: String = "+4915123456789"
    
    override func setUp() {
        container = Container()
        authService = AuthServiceMock()
        
        container.register(AuthService.self) { _ in
            self.authService
        }
        
        viewModel = OTPViewModel(
            container: container,
            phoneNumber: phoneNumber
        )
    }
    
    func test_whenVerifyOTPWithWrongInput_thenITShouldFail() async throws {
        //given
        let wrongInput = ["a", "b"]
        //when
        do {
            try await viewModel.verifyOTP(with: wrongInput)
            XCTFail("Should throw an error")
        } catch {
            //then
            switch error {
            case OTPViewModelError.otpNotValid:
                break
            default:
                XCTFail("It should throw OTPViewModelError")
            }
        }
    }
    
    func test_whenVerifyOTPWithShortInput_thenAuthenticateWithAuthService() async {
        //given
        let shortInput = ["1", "2", "3", "4", "5"]
        //when
        do {
            try await viewModel.verifyOTP(with: shortInput)
            XCTFail("Should throw an error")
        } catch {
            //then
            switch error {
            case OTPViewModelError.otpNotValid:
                break
            default:
                XCTFail("It should throw OTPViewModelError")
            }
        }
    }
    
    func test_whenVerifyOTPWithValidInput_thenAuthenticateWithAuthService() async throws {
        //given
        let validInput = ["1", "2", "3", "4", "5", "6"]
        //when
        try await viewModel.verifyOTP(with: validInput)
        //then
        XCTAssertEqual(authService.didAuthenticate.count, 1)
        XCTAssertEqual(authService.didAuthenticate.first, "123456")
    }
}







