import UIKit
import FirebaseDatabase
import VoxelAuthentication
import Swinject

public struct Contact {
    public let name: String
    public let image: UIImage?
    public let isOnline: Bool
    public let firstLetter: String
    public let phoneNumber: String
    
    public init(name: String, image: UIImage?, isOnline: Bool, firstLetter: String, phoneNumber: String) {
        self.name = name
        self.image = image
        self.isOnline = isOnline
        self.firstLetter = firstLetter
        self.phoneNumber = phoneNumber
    }
}

enum ContactsRepositoryError: Error {
    case contactNotRegistered
}

public protocol ContactsRepository {
    func fetch() async throws -> [Contact]
    func addContact(withPhoneNumber phoneNumber: String, fullName: String) async throws
}

public class ContactsRepositoryLive: ContactsRepository {
    
    private let reference: DatabaseReference
    private let phoneNumberReference: DatabaseReference
    private let container: Container
    private var authService: AuthService {
        container.resolve(AuthService.self)!
    }
    
    public init(container: Container) {
        self.container = container
        reference = Database.database().reference().child("contacts")
        phoneNumberReference = Database.database().reference().child(DatabaseBranch.phoneNumbers.rawValue)
    }
    
    public func fetch() async throws -> [Contact] {
        []
    }
    
    public func addContact(withPhoneNumber phoneNumber: String, fullName: String) async throws {
        let snapshot = try await phoneNumberReference.child(phoneNumber).getData()
        
        guard let contactUserId = snapshot.value as? String else {
            throw ContactsRepositoryError.contactNotRegistered
        }
        
        guard let user = authService.user else {
            throw AuthError.notAuthenticated
        }
        
        try await reference.child(user.uid).child(contactUserId).setValue([
            "name": fullName
        ])
    }
}
                                        
                                        
                                        
                                        
                                        
                                        
                                        
                                        
                                        
                                        
