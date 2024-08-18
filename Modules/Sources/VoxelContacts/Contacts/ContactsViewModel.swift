import UIKit
import Swinject

public final class ContactsViewModel {
    private let container: Container
    private let coordinator: ContactsCoordinator
    private var repository: ContactsRepository {
        container.resolve(ContactsRepository.self)!
    }

    private var contactsSource: [Contact] = []
    var contacts: [String: [Contact]] = [:]
    var sectionTitles: [String] = []

    public init(container: Container, coordinator: ContactsCoordinator) {
        self.container = container
        self.coordinator = coordinator
    }

    public func fetch() async throws {
        contactsSource = try await repository.fetch()

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
