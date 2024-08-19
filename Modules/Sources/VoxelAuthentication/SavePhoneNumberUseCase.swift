import Foundation
import FirebaseDatabase

protocol SavePhoneNumberUseCase {
    func execute() async throws
}

public enum DatabaseBranch: String {
    case phoneNumbers = "phoneNumbers"
}

class SavePhoneNumberUseCaseLive: SavePhoneNumberUseCase {
    
    private let authService: AuthService
    private let reference: DatabaseReference
    private let userReference: DatabaseReference
    private let phoneNumbersBranch = DatabaseBranch.phoneNumbers.rawValue
    
    init(authService: AuthService) {
        self.authService = authService
        reference = Database.database().reference().child(phoneNumbersBranch)
        userReference = Database.database().reference().child("users")
    }
    
    func execute() async throws {
        guard let user = authService.user else {
            throw AuthError.notAuthenticated
        }
        
        try await reference.child(user.phoneNumber).setValue(user.uid)
        try await userReference.child(user.uid).child("phoneNumber").setValue(user.phoneNumber)
    }
}









