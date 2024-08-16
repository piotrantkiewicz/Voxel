import Foundation

class ContactInfoViewModel {
    let contact: Contact
    private let coordinator: ContactInfoCoordinator

    init(contact: Contact, coordinator: ContactInfoCoordinator) {
        self.contact = contact
        self.coordinator = coordinator
    }

    func editContact() {
        coordinator.presentEditContact()
    }
}
