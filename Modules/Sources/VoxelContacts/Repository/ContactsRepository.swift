import UIKit
import FirebaseDatabase
import VoxelAuthentication
import VoxelSettings
import Swinject

public struct Contact {
    public let uid: String
    public let name: String
    public var phoneNumber: String {
        userProfile.phoneNumber
    }
    public let userProfile: UserProfile
}

enum ContactsRepositoryError: Error {
    case contactNotRegistered
}

public protocol ContactsRepository {
    func fetch() async throws -> [Contact]
    func addContact(withPhoneNumber phoneNumber: String, fullName: String) async throws
}

public struct ContactRelationship: Decodable {
    let name: String
}

public class ContactsRepositoryLive: ContactsRepository {
    
    private let reference: DatabaseReference
    private let phoneNumberReference: DatabaseReference
    private let usersReference: DatabaseReference
    private let container: Container
    private var authService: AuthService {
        container.resolve(AuthService.self)!
    }
    
    public init(container: Container) {
        self.container = container
        reference = Database.database().reference().child("contacts")
        phoneNumberReference = Database.database().reference().child(DatabaseBranch.phoneNumbers.rawValue)
        usersReference = Database.database().reference().child("users")
    }
    
    public func fetch() async throws -> [Contact] {
        
        guard let user = authService.user else {
            throw AuthError.notAuthenticated
        }
        
        let snapshot = try await reference.child(user.uid).getData()
        let contacts = try snapshot.data(as: [String: ContactRelationship].self)
        
        var contactsArray = [Contact]()
        
        try await withThrowingTaskGroup(of: Contact.self) { [unowned self] group in
            for (contactsUid, contactRel) in contacts {
                group.addTask{
                    let profile = try await self.fetchContact(with: contactsUid)
                    return Contact(
                        uid: contactsUid,
                        name: contactRel.name,
                        userProfile: profile
                    )
                }
            }
            
            for try await contact in group {
                contactsArray.append(contact)
            }
        }
        
        return contactsArray
    }
    
    private func fetchContact(with uid: String) async throws -> UserProfile {
        let snapshot = try await usersReference.child(uid).getData()
        return try snapshot.data(as: UserProfile.self)
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
                                        
                                        
                                        
                                        
                                        
                                        
                                        
                                        
                                        
                                        
