import UIKit
import VoxelContacts

public final class ContactsRepositoryFake: ContactsRepository {
    public func addContact(withPhoneNumber phoneNumber: String, fullName: String) async throws {

    }
    
    
    public init() {}
    
    public func fetch() async throws -> [Contact] {
        [
            Contact(name: "Arnold Watson", image: UIImage(named: "arnold"), isOnline: false, firstLetter: "A", phoneNumber: "+1 202-555-0101"),
            Contact(name: "Albert Flores", image: UIImage(named: "albert"), isOnline: false, firstLetter: "A", phoneNumber: "+1 202-555-0102"),
            Contact(name: "Andrew Fox", image: UIImage(named: "andrew"), isOnline: false, firstLetter: "A", phoneNumber: "+1 202-555-0103"),
            Contact(name: "Anderson Cooper", image: UIImage(named: "anderson"), isOnline: false, firstLetter: "A", phoneNumber: "+1 202-555-0104"),
            Contact(name: "Anthony Fisher", image: UIImage(named: "anthony"), isOnline: false, firstLetter: "A", phoneNumber: "+1 202-555-0105"),
            Contact(name: "Bernard Edwards", image: UIImage(named: "bernard"), isOnline: false, firstLetter: "B", phoneNumber: "+1 202-555-0201"),
            Contact(name: "Barak Nguyen", image: UIImage(named: "barak"), isOnline: false, firstLetter: "B", phoneNumber: "+1 202-555-0202"),
            Contact(name: "Bone Jones", image: UIImage(named: "bone"), isOnline: true, firstLetter: "B", phoneNumber: "+1 202-555-0203"),
            Contact(name: "Beslie Alexander", image: UIImage(named: "beslie"), isOnline: false, firstLetter: "B", phoneNumber: "+1 202-555-0204")
        ]
    }
}
