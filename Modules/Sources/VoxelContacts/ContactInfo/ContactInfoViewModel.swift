import Foundation
import Swinject

class ContactInfoViewModel {
    var contact: Contact
    private let coordinator: ContactInfoCoordinator
    private let container: Container
    private var repository: ContactsRepository {
        container.resolve(ContactsRepository.self)!
    }

    init(
        contact: Contact,
        coordinator: ContactInfoCoordinator,
        container: Container
    ) {
        self.contact = contact
        self.coordinator = coordinator
        self.container = container
    }

    func editContact() {
        coordinator.presentEditContact()
    }
    
    func fetch() async throws {
        contact = try await repository.fetchContact(with: contact.uid)
    }
}







