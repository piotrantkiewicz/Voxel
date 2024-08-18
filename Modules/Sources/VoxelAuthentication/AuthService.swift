import FirebaseAuth

public enum AuthError: Error {
    case noVerificationId
    case notAuthenticated
}

public struct User {
    public let uid: String
    public let phoneNumber: String

    public init(
        uid: String,
        phoneNumber: String
    ) {
        self.uid = uid
        self.phoneNumber = phoneNumber
    }
}

enum UserDefaultKey: String {
    case authVerificationId
}

public protocol AuthService {

    var user: User? { get }
    var isAuthenticated: Bool { get }

    func requestOTP(forPhoneNumber phoneNumber: String) async throws
    func authenticate(withOTP otp: String) async throws -> User
    func logout() throws
}

public class AuthServiceLive: AuthService {
    
    private lazy var savePhoneUseCase: SavePhoneNumberUseCase = { [unowned self] in
        SavePhoneNumberUseCaseLive(authService: self)
    }()

    public var isAuthenticated: Bool {
        Auth.auth().currentUser != nil
    }

    public var user: User? {
        guard let user = Auth.auth().currentUser else { return nil }
        guard let phoneNumber = user.phoneNumber else { return nil }
        return User(uid: user.uid, phoneNumber: phoneNumber)
    }

    public init() {}

    public func requestOTP(forPhoneNumber phoneNumber: String) async throws {

        let verificationID = try await PhoneAuthProvider.provider()
            .verifyPhoneNumber(phoneNumber, uiDelegate: nil)

        UserDefaults.standard.set(verificationID, forKey: UserDefaultKey.authVerificationId.rawValue)
    }

    public func authenticate(withOTP otp: String) async throws -> User {

        guard let verificationId = UserDefaults.standard.string(forKey: UserDefaultKey.authVerificationId.rawValue) else {
            throw AuthError.noVerificationId
        }

        let credential = PhoneAuthProvider.provider().credential(
            withVerificationID: verificationId,
            verificationCode: otp
        )

        let result = try await Auth.auth().signIn(with: credential)
        
        guard let user = user else {
            throw AuthError.notAuthenticated
        }
        
        try await savePhoneUseCase.execute()

        return user
    }

    public func logout() throws {
        try Auth.auth().signOut()
    }
}
