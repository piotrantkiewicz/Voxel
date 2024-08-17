import UIKit
import Swinject

public struct Contact {
    public let name: String
    public let image: UIImage?
    public let isOnline: Bool
    public let firstLetter: String
    public let phoneNumber: String
}

public final class ContactsViewModel {
    private let container: Container
    private let coordinator: ContactsCoordinator

    private var contactsSource: [Contact] = []
    var contacts: [String: [Contact]] = [:]
    var sectionTitles: [String] = []

    public init(container: Container, coordinator: ContactsCoordinator) {
        self.container = container
        self.coordinator = coordinator
    }

    public func fetch() async {
        // Simulating loading contacts with phone numbers
        contactsSource = [
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

        updateContacts(with: contactsSource)
    }
    
    func search(with query: String) {
        guard !query.isEmpty else {
            updateContacts(with: contactsSource)
            return
        }
        
        let searchResluts = contactsSource.filter {
            $0.name.lowercased().contains(query.lowercased()) ||
            $0.phoneNumber.contains(query)
        }
        
        didCompleteSearch(with: searchResluts)
    }
    
    private func didCompleteSearch(with results: [Contact]) {
        self.contacts = [
            ContactsStrings.contactsSection.rawValue: results
        ]
        sectionTitles = self.contacts.keys.sorted()
    }

    func didTapAddContact() {
        coordinator.presentAddContact()
    }

    private func updateContacts(with contacts: [Contact]) {
        self.contacts = Dictionary(grouping: contacts, by: { $0.firstLetter })
        sectionTitles = self.contacts.keys.sorted()
    }

    func didSelectContact(_ contact: Contact) {
        coordinator.showContactInfo(for: contact)
    }
}
