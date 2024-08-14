import Foundation
import VoxelAuthentication

class AuthServiceMock: AuthService {
    var user: User?
    
    var isAuthenticated: Bool = false
    
    func requestOTP(forPhoneNumber phoneNumber: String) async throws {}
    
    func authenticate(with otp: String) async throws -> User {
        User(uid: "123")
    }
    
    func logout() throws {}
}
