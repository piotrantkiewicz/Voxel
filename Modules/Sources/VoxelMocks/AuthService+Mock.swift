import VoxelAuthentication

public enum MockError: Error {
    case mock
}

public class AuthServiceMock: AuthService {

    public init() {}

    public var user: User?
    
    public var isAuthenticated: Bool = false

    public var didRequestOTP: [String] = []
    public var shouldThrowOnRequestOTP: Bool = false

    public func requestOTP(forPhoneNumber phoneNumber: String) async throws {
        didRequestOTP.append(phoneNumber)
        if shouldThrowOnRequestOTP {
            throw MockError.mock
        }
    }

    public var didAuthenticate: [String] = []

    public func authenticate(withOTP otp: String) async throws -> User {
        didAuthenticate.append(otp)

        return User(uid: "123")
    }

    public func logout() throws {}
}
